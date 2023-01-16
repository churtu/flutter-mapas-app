import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/src/blocs/blocs.dart';

class MapView extends StatelessWidget {
  final LatLng initialLocation;
   
  const MapView({
    Key? key, 
    required this.initialLocation
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    CameraPosition lugar = CameraPosition(
              target: initialLocation,
              zoom: 14.4746,
            );
            
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GoogleMap(
        initialCameraPosition: lugar,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: (controller) {
          mapBloc.add(OnMapInitializedEvent(controller));
        },
      ),
    );
  }
}