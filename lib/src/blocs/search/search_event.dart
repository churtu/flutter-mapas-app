part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnActivateManualMarkerEvent extends SearchEvent {}

class OnDesactivateManualMarkerEvent extends SearchEvent {}

class OnNewPlacesFoundEvent extends SearchEvent {
  final List<Feature>placesResults;

  const OnNewPlacesFoundEvent(this.placesResults);
}

class OnAddPlaceToHistory extends SearchEvent {
  final Feature place;

  const OnAddPlaceToHistory(this.place);

}

