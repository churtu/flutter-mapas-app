import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  late StreamSubscription<Position> positionSubscription;
  LocationBloc() : super(const LocationState()) {
    on<OnNewUserLocationEvent>((event, emit) {
      emit(state.copyWith(
        lastKnowPosition: event.location,
        myLocationHistory: [...state.myLocationHistory, event.location],
      ));
    });

    on<OnStartFollowingUser>((event, emit) {
      emit(state.copyWith(isFollowingUser: true));
    });

    on<OnStopFollowingUser>((event, emit) {
      emit(state.copyWith(isFollowingUser: false));
    });
  }

  Future<Position> getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    return position;
  }

  void startFollowingUser() {
    positionSubscription = Geolocator.getPositionStream().listen((event) {
      final position = event;
      add(OnNewUserLocationEvent(
          LatLng(position.latitude, position.longitude)));
    });
  }

  void stopFollowingUser() {
    positionSubscription.cancel();
    add(OnStopFollowingUser());
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}
