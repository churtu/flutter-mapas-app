import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/src/theme/theme.dart';

import '../blocs.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  
  GoogleMapController? _mapController;

  final LocationBloc locationBloc; 
  late StreamSubscription? locationSubscription;

  MapBloc({
    required this.locationBloc
  }) : super(const MapState(
    isFollowingUser: true,
    isMapInitialized: false
  )) {

    on<OnMapInitializedEvent>( _onInitMap );
    on<OnStartFollowingUserEvent>( _onStartFollowingUserEvent );
    on<OnStopFollowingUserEvent>( _onStopFollowingUserEvent );
    on<OnUpdateUserPolylineEvent>( _onUpdateUserPolylineEvent );
    on<OnToggleShowRouteEvent>( _onToggleShowRouteEvent );


    locationSubscription = locationBloc.stream.listen((locationState) { 
      if( !state.isFollowingUser ) return;
      if(locationState.lastKnowPosition == null) return;
      add(OnUpdateUserPolylineEvent(locationState.myLocationHistory));
      moveCamera(locationState.lastKnowPosition!);
    });

  }


    _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit){
      
      _mapController = event.mapController;
      _mapController!.setMapStyle(jsonEncode(mapTheme));
      emit(state.copyWith(isMapInitialized: true));

    }

    _onStartFollowingUserEvent(OnStartFollowingUserEvent event, Emitter<MapState> emit){
      
      emit(state.copyWith(isFollowingUser: true));
      if(locationBloc.state.lastKnowPosition == null) return;
      moveCamera(locationBloc.state.lastKnowPosition!);
    }

    _onStopFollowingUserEvent(OnStopFollowingUserEvent event, Emitter<MapState> emit){
      emit(state.copyWith(isFollowingUser: false));
    }

    _onUpdateUserPolylineEvent(OnUpdateUserPolylineEvent event, Emitter<MapState> emit) {
      final newPolyline = Polyline(
        polylineId: const PolylineId('mi-ruta'),
        color: Colors.black,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: event.history
      );
      
      final currentPolylines = Map<String, Polyline>.from(state.polylines);
      currentPolylines['mi-ruta'] = newPolyline;
      emit(state.copyWith(polylines: currentPolylines));
    }

  _onToggleShowRouteEvent(OnToggleShowRouteEvent event, Emitter<MapState>emit){
    emit(state.copyWith(showMyRoute: !state.showMyRoute));
  }

    void moveCamera( LatLng newLocation ){
      final cameraUpdate = CameraUpdate.newLatLng(
        newLocation
      );
      _mapController?.moveCamera(cameraUpdate);
    }
  @override
  Future<void> close() {
    locationSubscription?.cancel();
    return super.close();
  }
}
