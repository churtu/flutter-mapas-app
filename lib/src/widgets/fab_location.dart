import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/src/blocs/blocs.dart';
import 'package:mapas_app/src/ui/custom_snackbar.dart';

class FabLocation extends StatelessWidget {
  const FabLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapaBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(Icons.my_location_outlined, color: Colors.black,),
          onPressed: () {
            
            final userLocation = locationBloc.state.lastKnowPosition;
            if(userLocation == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: CustomSnackbar(message: 'Hola muindo')
              ));
              return;
            }

            mapaBloc.moveCamera(userLocation);
          },
        ),
      ),
    );
  }
}