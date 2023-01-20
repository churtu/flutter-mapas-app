part of 'map_bloc.dart';

class MapState extends Equatable {
  
  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showMyRoute;
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  const MapState({
    this.showMyRoute = true,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
    required this.isMapInitialized, 
    required this.isFollowingUser
  }) : polylines = polylines ?? const {},
      markers = markers ?? const {};

  
  @override
  List<Object> get props => [isFollowingUser, isMapInitialized, polylines, showMyRoute, markers];

  MapState copyWith({
    bool? showMyRoute,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
    bool? isMapInitialized,
    bool? isFollowingUser,
  }) => MapState(
    markers: markers ?? this.markers,
    showMyRoute: showMyRoute ?? this.showMyRoute,
    polylines: polylines ?? this.polylines,
    isFollowingUser: isFollowingUser ?? this.isFollowingUser,
    isMapInitialized: isMapInitialized ?? this.isMapInitialized
    ); 
}

