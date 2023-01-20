import 'package:flutter/material.dart';

class EndMarkerPainter extends CustomPainter {
  final String kms;
  final String destino;

  EndMarkerPainter({
    required this.kms, 
    required this.destino
  });

  @override
  void paint(Canvas canvas, Size size) {
      final blackPaint = Paint()
        ..color = Colors.black;
      final whitePaint = Paint()
        ..color = Colors.white;
      const double circleBlackRadius = 20;
      const double circleWhiteRadius = 7;

      canvas.drawCircle(
        Offset(size.width*.5,size.height-circleBlackRadius), 
        circleBlackRadius, 
        blackPaint
      );

      canvas.drawCircle(
        Offset(size.width*.5,size.height-circleBlackRadius), 
        circleWhiteRadius, 
        whitePaint
      );

      // CAJA NEGRA

      _buildCajaContenedora(size, canvas, whitePaint, blackPaint);

      // Texto caja negra
      _buildTextoCajaNegra(canvas, text: kms, label: 'kms');

      // Descripcion
      _buildDescripcionText(size, canvas);


  }

  void _buildDescripcionText(Size size, Canvas canvas) {
    final locationText = TextSpan(
    style: const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    text: destino
        );
    
        final locationPainter = TextPainter(
    maxLines: 2,
    ellipsis: '...',
    text: locationText,
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.left,
        )..layout(maxWidth: size.width-100, minWidth: size.width-100);
    
        final double offsetY = destino.length > 27 ? 35 : 48;
    
        locationPainter.paint(canvas, Offset(90, offsetY));
  }



  void _buildTextoCajaNegra(Canvas canvas,{ String? text, String? label }) {
    final textSpan = TextSpan(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w400,
      ),
      text: text
    );
    
    final minutesPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(minWidth: 70, maxWidth: 70);
    
    minutesPainter.paint(canvas, const Offset(10, 35));
    
    final textWordSpan = TextSpan(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      text: label
    );
    
    final minutesWordPainter = TextPainter(
      text: textWordSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(minWidth: 70, maxWidth: 70); 
    minutesWordPainter.paint(canvas, const Offset(10, 68));
  }

  void _buildCajaContenedora(Size size, Canvas canvas, Paint whitePaint, Paint blackPaint) {
    final fondoBlanco = Path();
    fondoBlanco.moveTo(10, 20);
    fondoBlanco.lineTo(size.width-10, 20);
    fondoBlanco.lineTo(size.width-10, 100);
    fondoBlanco.lineTo(size.width-10, 100);
    fondoBlanco.lineTo(10, 100);
    
    canvas.drawShadow(fondoBlanco, Colors.black, 10, false);
    canvas.drawPath(fondoBlanco, whitePaint);
    
    const blackBox = Rect.fromLTWH(10, 20, 70, 80);
    canvas.drawRect(blackBox, blackPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;

  
}