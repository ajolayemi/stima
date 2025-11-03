import 'dart:io';

import 'package:logging/logging.dart';
import 'package:stima/core/models/app_lat_lng.dart';
import 'package:stima/features/companies/enums/kml_folder_type.dart';
import 'package:stima/features/companies/models/placemark_from_kml.dart';
import 'package:xml/xml.dart';

class XmlFileParserUtils {
  const XmlFileParserUtils._();

  static final _logger = Logger('XmlFileParserUtils');

  /// Processes the provided KML [file] to extract the NetworkLink href
  static Future<String?> processCompanyKmlWithLink(File? file) async {
    _logger.fine('Starting to process company KML file for link extraction');
    final fileContent = _readXmlFileContents(file);

    if (fileContent == null) {
      return Future.value(null);
    }

    final xmlDocument = XmlDocument.parse(fileContent);

    // Access the xml's root element
    final rootElement = xmlDocument.rootElement;

    // Get the "Document" child element of the xml document
    final documentElement = rootElement.getElement('Document');

    if (documentElement == null) {
      _logger.fine('Exiting because no document element was found');
      return Future.value(null);
    }

    // Access the "NetworkLink" child element of the document element
    final networkLinkElement = documentElement.getElement('NetworkLink');

    if (networkLinkElement == null) {
      _logger.fine('Exiting because no network link element was found');
      return Future.value(null);
    }

    // Access the "Link" child element of the network link element
    final linkElement = networkLinkElement.getElement('Link');
    if (linkElement == null) {
      _logger.fine('Exiting because no link element was found');
      return Future.value(null);
    }

    // Access the "href" child element of the link element
    final hrefElement = linkElement.getElement('href');

    _logger.fine('href element inner text is: ${hrefElement?.innerText}');

    return hrefElement?.innerText;
  }

  /// Processes the provided KML [file] to extract placemarks categorized by folder types
  static Future<Map<String, List<PlacemarkFromKml>>?> processCompanyKml(
    File? file,
  ) async {
    _logger.fine('Starting to process company KML file');
    Map<String, List<PlacemarkFromKml>> processResult = {};

    final fileContent = _readXmlFileContents(file);

    if (fileContent == null) {
      return Future.value(null);
    }

    final xmlDocument = XmlDocument.parse(fileContent);

    // Access the xml's root element
    final rootElement = xmlDocument.rootElement;

    // Get the "Document" child element of the xml document
    final documentElement = rootElement.getElement('Document');

    if (documentElement == null) {
      return Future.value(null);
    }

    // Get the "Folder" children elements of the [documentElement]
    final foldersElements = documentElement.findElements(
      'Folder',
      namespace: documentElement.namespaceUri,
    );

    // _logDebug('got ${foldersElements.length} folders from documentElement');

    // Start looping over the predefined list that holds the name of the folders that will be accessed
    //
    for (final item in KmlFolderType.values) {
      _logger.fine('folder name being searched for: ${item.folderName}');
      // from the list of retrieved foldersElements, get all elements matching
      // the current [folderEl]'s name
      final matchingFolders = _filterXmlFolderByName(
        xmlFolders: foldersElements.toList(),
        name: item.folderName,
      );

      // _logDebug('found matching folder: ${matchingFolders.isNotEmpty}');
      final folderPlacemarksResult = _processFolders(
        folders: matchingFolders,
        folderType: item,
      );

      processResult[item.folderName] = folderPlacemarksResult;
    }

    return processResult;
  }

  /// Given a list of [XmlElement]s which are list of folders elements already filtered by a specific name
  /// This function helps in looping over each element and accessing there Placemark elements
  static List<PlacemarkFromKml> _processFolders({
    required List<XmlElement> folders,
    required KmlFolderType folderType,
  }) {
    List<PlacemarkFromKml> folderResult = [];
    // Loop over each folder and access it's "Placemark" children
    for (final folder in folders) {
      final folderPlacemarks = folder.findElements(
        'Placemark',
        namespace: folder.namespaceUri,
      );

      final placemarks = _processFolderPlacemarks(
        placemarks: folderPlacemarks.toList(),
        folderType: folderType,
      );

      folderResult.addAll(placemarks);
    }

    return folderResult;
  }

  /// Given a list of [XmlElement]s which are the placemarks belonging to a specific folder
  /// indicated by [folderType], it helps in processing the processing the provided placemarks
  static List<PlacemarkFromKml> _processFolderPlacemarks({
    required List<XmlElement> placemarks,
    required KmlFolderType folderType,
  }) {
    List<PlacemarkFromKml> res = [];
    for (final placemark in placemarks) {
      // Keep track of the namespace of the current placemark element
      final placeMarkNamespace = placemark.namespaceUri;

      // Get the <name> child element of the current placemark
      final placemarkName = placemark
          .getElement('name', namespace: placeMarkNamespace)
          ?.innerText;

      if (placemarkName == null || placemarkName.isEmpty) {
        continue;
      }
      _logger.info('placemark name: $placemarkName');

      // Get the <styleUrl> child element of the current placemark
      final placemarkStyle =
          placemark
              .getElement('styleUrl', namespace: placeMarkNamespace)
              ?.innerText
              .split('-') ??
          [];
      // _logDebug('placemark style: $placemarkStyle');

      final placemarkHexColor =
          placemarkStyle.isEmpty || placemarkStyle.length < 3
          ? null
          : placemarkStyle[2];

      // _logDebug('placemark hex color: $placemarkHexColor');

      // Based on the folder that is being accessed, get either the <Polygon> child or <Point> child of the current placemark
      // <Polygon> for "stacchi produttivi" folder while <Point> for "Accessi" folder
      final pointOrPolygonChild = placemark.getElement(
        folderType.isForAccess ? 'Point' : 'Polygon',
        namespace: placeMarkNamespace,
      );

      if (pointOrPolygonChild == null) continue;

      // Get placemark coordinates
      final markerCoordinates = getPlacemarkCoordinates(
        polygonOrPointElement: pointOrPolygonChild,
        isAPointElement: folderType.isForAccess,
      );

      // Get placemark centroid coordinates
      final centerCoordinates = calculatePolygonCentroid(markerCoordinates);

      res.add(
        PlacemarkFromKml(
          placeMarkId: placemarkName,
          coordinates: markerCoordinates,
          centroidCoordinates: centerCoordinates,
          hexColorCode: placemarkHexColor,
        ),
      );
      _logger.info('marker centroid coordinates: $centerCoordinates');
    }

    return res;
  }

  /// Accesses and processes the coordinates of a \<Point>\ or \<Polygon>\ XML document
  /// [polygonOrPointElement] is the [XmlElement] to be processed which can either be a Point or a Polygon
  /// [isAPointElement] indicates whether the provided element is a Point or not
  /// returns a list of [AppLatLng]
  static List<AppLatLng> getPlacemarkCoordinates({
    required XmlElement polygonOrPointElement,
    bool isAPointElement = false,
  }) {
    final namespace = polygonOrPointElement.namespaceUri;

    switch (isAPointElement) {
      case true:
        final pointCoordinates = polygonOrPointElement
            .getElement('coordinates', namespace: namespace)
            ?.innerText
            .trim()
            .split(' ')
            .where((coordinate) => coordinate.isNotEmpty)
            .toList();
        // _logDebug('found points coordinates: $pointCoordinates');
        return _convertXmlCoordinates(coordinates: pointCoordinates);
      case false:
        final polygonOuterBoundaryElement = polygonOrPointElement.getElement(
          'outerBoundaryIs',
          namespace: namespace,
        );

        if (polygonOuterBoundaryElement == null) return [];

        final linearRingElement = polygonOuterBoundaryElement.getElement(
          'LinearRing',
          namespace: polygonOuterBoundaryElement.namespaceUri,
        );

        if (linearRingElement == null) return [];

        final polygonCoordinates = linearRingElement
            .getElement(
              'coordinates',
              namespace: linearRingElement.namespaceUri,
            )
            ?.innerText
            .trim()
            .split(' ')
            .where((coordinates) => coordinates.isNotEmpty)
            .toList();
        // _logDebug('found polygon coordinates: $polygonCoordinates');
        return _convertXmlCoordinates(coordinates: polygonCoordinates);
    }
  }

  static List<AppLatLng> _convertXmlCoordinates({List<String>? coordinates}) {
    if (coordinates == null || coordinates.isEmpty) {
      return [];
    }
    List<AppLatLng> res = [];
    for (final coordinate in coordinates) {
      final data = coordinate.split(',');
      if (data.length <= 1) continue;

      final lat = double.tryParse(data[1]);
      final longitude = double.tryParse(data[0]);

      if (lat == null || longitude == null) continue;

      res.add(AppLatLng(latitude: lat, longitude: longitude));
    }

    return res;
  }

  static AppLatLng calculatePolygonCentroid(List<AppLatLng> coordinates) {
    double totalLatitude = coordinates.fold(0.0, (previousValue, coordinates) {
      return previousValue += coordinates.latitude;
    });

    double totalLongitude = coordinates.fold(0.0, (previousValue, coordinates) {
      return previousValue += coordinates.longitude;
    });

    return AppLatLng(
      latitude: totalLatitude / coordinates.length,
      longitude: totalLongitude / coordinates.length,
    );
  }

  /// Given a list of [xmlFolders] retrieved from a company's KML / XML, this function
  /// helps in filtering out all the folder elements that belongs to the provided [name]
  static List<XmlElement> _filterXmlFolderByName({
    required List<XmlElement> xmlFolders,
    required String name,
  }) {
    return xmlFolders.where((item) {
      final folderName = item.getElement('name')?.innerText;
      // _logDebug('folder name from xml: $folderName');
      return name.toLowerCase() == folderName?.toLowerCase();
    }).toList();
  }

  static String? _readXmlFileContents(File? file) {
    if (file == null) {
      return null;
    }

    return file.readAsStringSync();
  }
}
