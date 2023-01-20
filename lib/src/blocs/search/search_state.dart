part of 'search_bloc.dart';

class SearchState extends Equatable {
  final bool displayManualMarker;
  final List<Feature> placesResults;
  final List<Feature> history;

  const SearchState({
    this.history = const [],
    this.displayManualMarker = false,
    this.placesResults = const []
  });

  SearchState copyWith({
    List<Feature>? history,
    bool? displayManualMarker,
    List<Feature>? placesResults
  }) => SearchState(
    displayManualMarker: displayManualMarker ?? this.displayManualMarker,
    placesResults: placesResults ?? this.placesResults,
    history: history ?? this.history
  );
  
  @override
  List<Object> get props => [displayManualMarker, placesResults, history];
}
