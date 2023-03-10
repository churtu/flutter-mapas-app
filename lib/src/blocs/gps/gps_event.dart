part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}

class OnGpsAndPermissionEvent extends GpsEvent {
  final bool? isGpsEnabled;
  final bool? isGpsPermissionGranted;

  const OnGpsAndPermissionEvent({
    this.isGpsEnabled, 
    this.isGpsPermissionGranted
  });

}
