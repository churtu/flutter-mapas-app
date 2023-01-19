import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchResult {
  final bool isCanceled;
  final bool manual;
  final LatLng? position; 
  final String? name;
  final String? description;

  SearchResult({
    required this.isCanceled, 
    this.manual = false,
    this.name,
    this.description,
    this.position
  });

}