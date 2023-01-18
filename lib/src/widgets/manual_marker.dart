import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/src/blocs/blocs.dart';
import 'package:mapas_app/src/helpers/helpers.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker ? _ManualMarkerBody() : const SizedBox();
      },
    );
  }
}

class _ManualMarkerBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          _BtnBack(),
          _CenterIcon(),
          _ConfirmBtn(size: size)

        ],
      ),
    );
  }
}

class _ConfirmBtn extends StatelessWidget {
  const _ConfirmBtn({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
  final searchBloc = BlocProvider.of<SearchBloc>(context);
  final locationBloc = BlocProvider.of<LocationBloc>(context);
  final mapBloc = BlocProvider.of<MapBloc>(context);
    return Positioned(
      bottom: 70,
      left: 40,
      child: FadeInUp(
        duration: const Duration(milliseconds: 300),
        child: MaterialButton(
          color: Colors.black,
          elevation: 0,
          height: 50,
          shape: const StadiumBorder(),
          minWidth: size.width-120,
          onPressed: ()async{
            final start = locationBloc.state.lastKnowPosition;
            final end = mapBloc.mapCenter;
            if(start == null || end == null) return;
            showLoadingMessage(context);
            final response = await searchBloc.getCoorsStartToEnd( start, end );
            
            await mapBloc.drawRoutePolyline(response).then((_) {
              searchBloc.add(OnDesactivateManualMarkerEvent());
              Navigator.pop(context);
            });
            
          },
          child: const Text('Confirmar destino', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
        ),
      ),
    );
  }
}

class _CenterIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.translate(
        offset: const Offset(0, -22),
        child: BounceInDown(
          from: 100,
          child: const Icon(Icons.location_on_rounded, size: 50)),
      ),
    );
  }
}

class _BtnBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    return Positioned(
      left: 20,
      top: 70,
      child: FadeInLeft(
        duration: const Duration(milliseconds: 300),
        child: CircleAvatar(
          maxRadius: 25,
          backgroundColor: Colors.white,
          child: IconButton(
            onPressed: () => searchBloc.add(OnDesactivateManualMarkerEvent()),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black,))),
      ));
  }
}