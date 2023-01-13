import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/src/blocs/gps/gps_bloc.dart';

class GPSAccessScreen extends StatelessWidget {
   
  const GPSAccessScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            return !state.isGpsEnabled 
              ? _EnableGpsMessage()
              : _AccessButton();
          },
        ),
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Es necesario el acceso a GPS.',
            ),
          MaterialButton(
            color: Colors.black,
            onPressed: (){
              final gpsBloc = BlocProvider.of<GpsBloc>(context);
              gpsBloc.askGpsAccess();
            },
            child: const Text('Solicitar acceso', style: TextStyle(color: Colors.white))),
        ],
      ));
  }
}

class _EnableGpsMessage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Center(
       child: Text(
        'Debe habilitar el GPS.', 
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w300)
          )
    );
  }
}