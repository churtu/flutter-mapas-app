
import 'package:flutter/material.dart';
import 'package:mapas_app/src/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {

  SearchDestinationDelegate():super(searchFieldLabel: 'Buscar...');
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: (){
          close(context, SearchResult(isCanceled: true));
        },
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults', style: TextStyle(color: Colors.red),);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.location_on_outlined, color: Colors.black,),
          title: const Text('Colocar la ubicación manualmente', style: TextStyle(color: Colors.black),),
          onTap: () {
            close(context, SearchResult(isCanceled: false, manual: true));
          },
        )
      ],
    );
  }
  
}