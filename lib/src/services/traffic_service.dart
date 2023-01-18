import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:mapas_app/src/models/models.dart';
import 'package:mapas_app/src/services/services.dart';

class TrafficService {
    final Dio trafficApi;

    final _baseUrl = 'https://api.mapbox.com/directions/v5/mapbox'; 

    TrafficService()
      : trafficApi = Dio()..interceptors.add(TrafficInterceptor());

    Future<TrafficResponse> getCoorsStartToEnd( LatLng start, LatLng end )async {
      final coors = '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
      final url = '$_baseUrl/driving/$coors';
      final response = await trafficApi.get(url);
      final trafficResponse = TrafficResponse.fromMap(response.data);
      return trafficResponse;
    }
}