import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/src/blocs/blocs.dart';
import 'package:mapas_app/src/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {
  SearchDestinationDelegate() : super(searchFieldLabel: 'Buscar...');
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, SearchResult(isCanceled: true));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    searchBloc.getPlacesByQuery(locationBloc.state.lastKnowPosition!, query);
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.placesResults.isNotEmpty) {
          return ListView.separated(
            itemCount: state.placesResults.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final place = state.placesResults[index];
              return ListTile(
                title: Text(place.text),
                subtitle: Text(place.placeName),
                leading: const Icon(Icons.place_outlined, color: Colors.black),
                onTap: () {
                  close(
                      context,
                      SearchResult(
                          isCanceled: false,
                          manual: false,
                          position: LatLng(place.center[1], place.center[0]),
                          name: place.text,
                          description: place.placeName));
                  searchBloc.add(OnAddPlaceToHistory(place));
                },
              );
            },
          );
        }
        return ListView(
          children: [
            ListTile(
              leading: const Icon(
                Icons.location_on_outlined,
                color: Colors.black,
              ),
              title: const Text(
                'Colocar la ubicación manualmente',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                close(context, SearchResult(isCanceled: false, manual: true));
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    return ListView(
      children: [
        ListTile(
          leading: const Icon(
            Icons.location_on_outlined,
            color: Colors.black,
          ),
          title: const Text(
            'Colocar la ubicación manualmente',
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            close(context, SearchResult(isCanceled: false, manual: true));
          },
        ),
        ..._buildPlacesHistory(context)
      ],
    );
  }

  List<ListTile>_buildPlacesHistory(BuildContext context){
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final List<ListTile> history = searchBloc.state.history.map(((place) => ListTile(
                      title: Text(place.text),
                      subtitle: Text(place.placeName),
                      leading: const Icon(
                        Icons.history,
                        color: Colors.black,
                      ),
                      onTap: () => close(
                      context,
                      SearchResult(
                          isCanceled: false,
                          manual: false,
                          position: LatLng(place.center[1], place.center[0]),
                          name: place.text,
                          description: place.placeName)),
                    ))).toList();
    return history;
  }
}
