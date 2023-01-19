import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/src/blocs/blocs.dart';
import 'package:mapas_app/src/blocs/search/search_bloc.dart';
import 'package:mapas_app/src/delegates/delegates.dart';
import 'package:mapas_app/src/models/search_result.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker ? const SizedBox() : _SearchBarBody();
      },
    );
  }
}

class _SearchBarBody extends StatelessWidget {
  _onSearchResults(BuildContext context, SearchResult result) async {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    if (result.manual) {
      searchBloc.add(OnActivateManualMarkerEvent());
      return;
    }

    if(result.position!=null){
      final destination = await searchBloc.getCoorsStartToEnd( locationBloc.state.lastKnowPosition!, result.position!);
      await mapBloc.drawRoutePolyline(destination);
      mapBloc.moveCamera(result.position!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 300),
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child: GestureDetector(
            onTap: () async {
              await showSearch(
                      context: context, delegate: SearchDestinationDelegate())
                  .then((result) {
                if (result == null) return;
                _onSearchResults(context, result);
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 5))
                  ]),
              child: const Text(
                'Donde quieres ir?',
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
