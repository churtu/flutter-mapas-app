import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {

  StreamSubscription? gpsServiceSubscription;

  GpsBloc() : super(const GpsState(
    isGpsEnabled: false, 
    isGpsPermissionGranted: false
  )) {
    
    on<OnGpsAndPermissionEvent>((event, emit) => emit(state.copyWith(
      isGpsEnabled: event.isGpsEnabled, 
      isGpsPermissionGranted: event.isGpsPermissionGranted
    )));

    _init();
  }

  Future _init() async {
    final gpsInitStatus = await Future.wait([
      _checkGpsStatus(),
      _isPermissionGranted()
    ]);
    add(OnGpsAndPermissionEvent(
      isGpsEnabled: gpsInitStatus[0], 
      isGpsPermissionGranted: gpsInitStatus[1]
    ));
  }

  Future<bool>_isPermissionGranted() async{
    final isGranter = await Permission.location.isGranted;
    return isGranter;
  }

  Future<bool> _checkGpsStatus() async {
    
    final bool isEnabled = await Geolocator.isLocationServiceEnabled();
    gpsServiceSubscription = Geolocator.getServiceStatusStream().listen((serviceStatus) {
      final bool isEnable = serviceStatus.index == 1;
      add(OnGpsAndPermissionEvent(isGpsEnabled: isEnable));
    });
    return isEnabled;
  }

  Future askGpsAccess() async {
    final status = await Permission.location.request();
    switch (status) {
      case PermissionStatus.granted:
        add(const OnGpsAndPermissionEvent(isGpsPermissionGranted: true));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(const OnGpsAndPermissionEvent(isGpsPermissionGranted: false));
        openAppSettings();
        break;
    }
  }

  @override
  Future<void> close() {
    gpsServiceSubscription?.cancel();
    return super.close();
  }
}
