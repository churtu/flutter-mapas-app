import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/src/theme/theme.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  
  GoogleMapController? _mapController;

  MapBloc() : super(const MapState(
    isFollowingUser: false,
    isMapInitialized: false
  )) {

    on<OnMapInitializedEvent>( _onInitMap );

  }


    _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit){
      
      _mapController = event.mapController;
      _mapController!.setMapStyle(jsonEncode(mapTheme));
      emit(state.copyWith(isMapInitialized: true));

    }
    void moveCamera( LatLng newLocation ){
      final cameraUpdate = CameraUpdate.newLatLng(
        newLocation
      );
      _mapController?.moveCamera(cameraUpdate);
    }
}
