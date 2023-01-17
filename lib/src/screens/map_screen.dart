import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/src/blocs/blocs.dart';
import 'package:mapas_app/src/views/views.dart';
import 'package:mapas_app/src/widgets/fab_follow.dart';
import 'package:mapas_app/src/widgets/widgets.dart';

class MapScreen extends StatefulWidget {
   

   
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();

}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;
  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    super.dispose();
    locationBloc.stopFollowingUser();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          if(locationState.lastKnowPosition == null) {
            return const Center(
              child: Text('Espere...'),
            );
          }

          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              Map<String, Polyline>polylines = Map.from(mapState.polylines);
              if(!mapState.showMyRoute){
                polylines.removeWhere((key, value) => key == 'mi-ruta');
              }
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    MapView(
                      initialLocation: locationState.lastKnowPosition!,
                      polylines: polylines.values.toSet(),
                    )
                  ],
                ),
              );
            }
          );
        },
      
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          FabFollow(),
          FabLocation(),
        ]
      ),
    );
  }
}