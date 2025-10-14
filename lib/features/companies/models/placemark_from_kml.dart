// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:stima/core/models/app_lat_lng.dart';

class PlacemarkFromKml {
  final String placeMarkId;
  final List<AppLatLng> coordinates;
  final AppLatLng centroidCoordinates;
  final String? hexColorCode;
  const PlacemarkFromKml({
    required this.placeMarkId,
    required this.coordinates,
    required this.centroidCoordinates,
    this.hexColorCode,
  });
}
