import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/src/blocs/blocs.dart';

class MapView extends StatelessWidget {
  final LatLng initialLocation;
  final Set<Polyline> polylines;
  final Set<Marker> markers;
  const MapView({
    Key? key, 
    required this.markers,
    required this.polylines,
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
      child: Listener(
        onPointerMove: (event) {
          mapBloc.add(OnStopFollowingUserEvent());
        },
        child: GoogleMap(
          initialCameraPosition: lugar,
          compassEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          polylines: polylines,
          markers: markers,
          onMapCreated: (controller) => mapBloc.add(OnMapInitializedEvent(controller)),
          onCameraMove: (position) => mapBloc.mapCenter = position.target,
        ),
      ),
    );
  }
}