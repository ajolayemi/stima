import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:stima/core/exceptions/app_exception.dart';

/// Reusable network helper using Dio.
/// - Supports GET/POST/PUT/DELETE/PATCH
/// - File download with progress (requires a temp directory to be provided)
/// - Centralized logging via `package:logging`
class NetworkRequests {
  static NetworkRequests? _instance;

  final Dio _dio;
  final Logger _logger = Logger('NetworkRequests');

  factory NetworkRequests() {
    _instance ??= NetworkRequests._internal();
    return _instance!;
  }

  NetworkRequests._internal()
    : _dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 15),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      ) {
    _setupInterceptors();
  }

  // Set Authorization header (e.g. Bearer token)
  void setAuthorization(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
    _logger.fine('Authorization header updated');
  }

  void clearAuthorization() {
    _dio.options.headers.remove('Authorization');
    _logger.fine('Authorization header removed');
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.info(() {
            final sb = StringBuffer();
            sb.writeln('--> ${options.method} ${options.uri}');
            sb.writeln('Headers: ${options.headers}');
            if (options.data != null) {
              final body = options.data is FormData
                  ? '<form-data>'
                  : options.data;
              sb.writeln('Body: $body');
            }
            return sb.toString();
          }());
          handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.info(() {
            final sb = StringBuffer();
            sb.writeln(
              '<-- ${response.statusCode} ${response.requestOptions.uri}',
            );
            final content = response.data is String
                ? response.data
                : jsonEncode(_tryJsonEncode(response.data));
            sb.writeln('Response: $content');
            return sb.toString();
          }());
          handler.next(response);
        },
        onError: (err, handler) {
          _logger.severe(() {
            final sb = StringBuffer();
            sb.writeln('*** DioException ***');
            sb.writeln('URL: ${err.requestOptions.uri}');
            sb.writeln('Type: ${err.type}');
            if (err.response != null) {
              sb.writeln('Status: ${err.response?.statusCode}');
              sb.writeln('Data: ${err.response?.data}');
            }
            sb.writeln('Message: ${err.message}');
            return sb.toString();
          }());
          handler.next(err);
        },
      ),
    );
  }

  dynamic _tryJsonEncode(dynamic data) {
    try {
      return jsonDecode(jsonEncode(data));
    } catch (_) {
      return data?.toString();
    }
  }

  // Generic GET - expects full URL
  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.get<T>(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _wrapDioError(e);
    }
  }

  // Generic POST - expects full URL
  Future<Response<T>> post<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.post<T>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _wrapDioError(e);
    }
  }

  // Generic PUT - expects full URL
  Future<Response<T>> put<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.put<T>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _wrapDioError(e);
    }
  }

  // Generic PATCH - expects full URL
  Future<Response<T>> patch<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.patch<T>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _wrapDioError(e);
    }
  }

  // Generic DELETE - expects full URL
  Future<Response<T>> delete<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete<T>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _wrapDioError(e);
    }
  }

  /// Download file to local path.
  /// - [tempDir] is required and should be a directory path where the file will be saved.
  /// - I
  Future<File> downloadFile(
    String url, {
    required String tempDir,
    required String fileName,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    Options? options,
    bool overwrite = true,
  }) async {
    final directory = Directory(tempDir);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    final savePath = p.join(directory.path, fileName);

    if (!overwrite && File(savePath).existsSync()) {
      _logger.info('File already exists, skipping download: $savePath');
      return File(savePath);
    }

    try {
      await _dio.download(
        url,
        savePath,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        options: options,
      );
      _logger.info('Downloaded file saved to $savePath');
      return File(savePath);
    } on DioException catch (e) {
      throw _wrapDioError(e);
    }
  }

  NetworkException _wrapDioError(DioException err) {
    final status = err.response?.statusCode;
    final data = err.response?.data;
    final message = err.message ?? 'Network error';
    _logger.warning('Wrapping DioException: status=$status, message=$message');
    return NetworkException( 
      message: message,
      statusCode: status,
      data: data,
      original: err,
      
    );
  }
}


