import 'package:flutter/material.dart';
import 'package:mapas_app/src/painters/painters.dart';

class TestMarkerScreen extends StatelessWidget {
   
  const TestMarkerScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
         child: Container(
          width: 350,
          height: 150,
          color: Colors.grey[400],
          child: CustomPaint(
            painter: EndMarkerPainter(
              kms: '86',
              destino: 'Casa de la chini y laasnskja'
            ),
          )
        ),
      ),
    );
  }
}