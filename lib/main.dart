import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/src/blocs/blocs.dart';
import 'package:mapas_app/src/screens/screens.dart';
import 'package:mapas_app/src/services/services.dart';

void main() => runApp(const MapsState());

class MapsState extends StatelessWidget {
  const MapsState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GpsBloc()),
        BlocProvider(create: (_) => LocationBloc()),
        BlocProvider(create: (context) => MapBloc(
          locationBloc: BlocProvider.of<LocationBloc>(context)
        )),
        BlocProvider(create: (_) => SearchBloc(trafficService: TrafficService()))
      ], child: const MapasApp());
  }
}

class MapasApp extends StatelessWidget {
  const MapasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: LoadingScreen(),
    );
  }
}