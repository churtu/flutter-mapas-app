part of 'map_bloc.dart';

class MapState extends Equatable {
  
  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showMyRoute;
  final Map<String, Polyline> polylines;

  const MapState({
    this.showMyRoute = true,
    Map<String, Polyline>? polylines,
    required this.isMapInitialized, 
    required this.isFollowingUser
  }) : polylines = polylines ?? const {};
  
  @override
  List<Object> get props => [isFollowingUser, isMapInitialized, polylines, showMyRoute];

  MapState copyWith({
    bool? showMyRoute,
    Map<String, Polyline>? polylines,
    bool? isMapInitialized,
    bool? isFollowingUser,
  }) => MapState(
    showMyRoute: showMyRoute ?? this.showMyRoute,
    polylines: polylines ?? this.polylines,
    isFollowingUser: isFollowingUser ?? this.isFollowingUser,
    isMapInitialized: isMapInitialized ?? this.isMapInitialized
    ); 
}

