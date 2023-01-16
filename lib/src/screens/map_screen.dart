import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/src/blocs/blocs.dart';

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
        builder: (context, state) {
          if(state.lastKnowPosition == null) {
            return const Center(
              child: Text('Espere...'),
            );
          }

          final latlng = LatLng(
            state.lastKnowPosition!.latitude,
            state.lastKnowPosition!.longitude
          );

          CameraPosition lugar = CameraPosition(
              target: latlng,
              zoom: 14.4746,
            );

            return GoogleMap(
              initialCameraPosition: lugar
            );
        },
      
      ),
    );
  }
}