import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/src/blocs/gps/gps_bloc.dart';
import 'package:mapas_app/src/screens/screens.dart';

void main() => runApp(const MapsState());

class MapsState extends StatelessWidget {
  const MapsState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GpsBloc())
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