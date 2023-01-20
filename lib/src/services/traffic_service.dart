import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:mapas_app/src/models/models.dart';
import 'package:mapas_app/src/services/services.dart';

class TrafficService {
  final Dio trafficApi;
  final Dio placesApi;

  final _baseUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  final _basePlacesUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';

  TrafficService()
      : trafficApi = Dio()..interceptors.add(TrafficInterceptor()),
        placesApi = Dio()..interceptors.add(PlacesInterceptor());

  Future<TrafficResponse> getCoorsStartToEnd(LatLng start, LatLng end) async {
    final coors =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '$_baseUrl/driving/$coors';
    final response = await trafficApi.get(url);
    final trafficResponse = TrafficResponse.fromMap(response.data);
    return trafficResponse;
  }

  Future<List<Feature>> getResultsByQuery(
      String query, LatLng proximity) async {
    try {
      if (query.isEmpty) return [];
      final url = '$_basePlacesUrl/$query.json';
      final response = await placesApi.get(url, queryParameters: {
        'proximity': '${proximity.longitude},${proximity.latitude}',
        'limit': 7
      });

      final placesResponse = PlacesResponse.fromMap(response.data);

      return placesResponse.features;
    } catch (e) {
      return [];
    }
  }

  Future<Feature?> getFeatureByCoors(LatLng coors) async {
    try {
      final url = '$_basePlacesUrl/${coors.longitude},${coors.latitude}.json';
      final response = await placesApi.get(url, queryParameters: {
        'limit': 1
      });

      final placesResponse = PlacesResponse.fromMap(response.data);

      return placesResponse.features.first;
    } catch (e) {
      return null;
    }
  }
}
