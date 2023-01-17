part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent {
  final GoogleMapController mapController;
  const OnMapInitializedEvent(this.mapController);
}

class OnStopFollowingUserEvent extends MapEvent{}
class OnStartFollowingUserEvent extends MapEvent{}

class OnUpdateUserPolylineEvent extends MapEvent {
  final List<LatLng>history;

  const OnUpdateUserPolylineEvent(this.history);
}

class OnToggleShowRouteEvent extends MapEvent{}
