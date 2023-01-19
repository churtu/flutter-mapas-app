import 'package:dio/dio.dart';
import 'package:mapas_app/src/environment/environment.dart';

class PlacesInterceptor extends Interceptor{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'country'     : 'cl',
      'limit'       : 7,
      'types'       : 'place,postcode,address',
      'language'    : 'es',
      'access_token': Environments.mapboxToken
    });
    super.onRequest(options, handler);
  }

}