import 'package:dio/dio.dart';
import 'package:mapas_app/src/environment/environment.dart';

class TrafficInterceptor extends Interceptor{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries'  : 'polyline6',
      'language'    : 'es',
      'overview'    : 'simplified',
      'steps'       : true,
      'access_token': Environments.mapboxToken

    });
    super.onRequest(options, handler);
  }

}