import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:mapas_app/src/models/models.dart';
import 'package:mapas_app/src/services/services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  final TrafficService trafficService;

  SearchBloc({
    required this.trafficService}) : super(const SearchState()) {
    on<OnActivateManualMarkerEvent>((event, emit) {
      emit(state.copyWith(displayManualMarker: true));
    });

    on<OnDesactivateManualMarkerEvent>((event, emit){
      emit(state.copyWith(displayManualMarker: false));
    });

    on<OnNewPlacesFoundEvent>((event, emit){
      emit(state.copyWith(placesResult: event.placesResults));
    });

    on<OnAddPlaceToHistory>((event, emit) 
      => emit(state.copyWith(history: [ event.place, ...state.history ])));

    
  }

  Future<RouteDestination> getCoorsStartToEnd(LatLng start, LatLng end)async{
    final trafficResponse = await trafficService.getCoorsStartToEnd(start, end);
    
    final distance = trafficResponse.routes![0]!.distance;
    final duration = trafficResponse.routes![0]!.duration;
    
    final geometry = trafficResponse.routes![0]!.geometry!;
    final points = decodePolyline(geometry, accuracyExponent: 6);
    final latLngList = points.map((coors) => LatLng(coors[0].toDouble(), coors[1].toDouble())).toList();

    final routeDestination = RouteDestination(
      distance: distance!,
      duration: duration!,
      points: latLngList
    );

    return routeDestination;
  }

  Future getPlacesByQuery(LatLng proximity, String query)async{
    final newPlaces = await trafficService.getResultsByQuery(query, proximity);
    add(OnNewPlacesFoundEvent(newPlaces));
  }
}
