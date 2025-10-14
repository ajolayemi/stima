class FileUtils {
  const FileUtils._();

  /// Given the bytes of a file, it returns a [String] representation of the file size
  /// in a human readable format (e.g., KB, MB, GB).

  static String getFileSizeString(int bytesSize, {int decimalPlaces = 2}) {
    final inKb = bytesSize / 1000;
    final inMb = bytesSize / 1000000;

    if (inMb < 1) {
      return '${inKb.toStringAsFixed(decimalPlaces)} KB';
    }

    return '${inMb.toStringAsFixed(decimalPlaces)} MB';
  }
}
