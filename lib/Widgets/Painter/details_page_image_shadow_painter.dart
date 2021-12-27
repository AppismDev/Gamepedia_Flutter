import 'package:flutter/material.dart';

class DetailsPageImageShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    // here are my custom shapes
    path.lineTo(0, 4 * size.height / 5);
    Offset curvePoint = Offset(size.width / 2, size.height);
    Offset endPoint = Offset(size.width, 4 * size.height / 5);
    path.quadraticBezierTo(
      curvePoint.dx,
      curvePoint.dy,
      endPoint.dx,
      endPoint.dy,
    );
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawShadow(path, Colors.black, 36.0, false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}