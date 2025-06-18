import 'package:flutter/material.dart';
import 'dart:math';

class GlitterContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double glitterWidth = 180;
    final double glitterHeight = 250;
    final double maxRadius = 15;

    final List<Offset> glitterPositions = List.generate(
      100,
      (_) => Offset(
        Random().nextDouble() * (glitterWidth - maxRadius * 2) + maxRadius,
        Random().nextDouble() * (glitterHeight - maxRadius * 2) + maxRadius,
      ),
    );

    final List<double> glitterRadii = List.generate(
      100,
      (_) => Random().nextDouble() * 4 + 2,
    );
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Container(width: double.infinity, height: 200, color: Colors.white),

            // Glitter overlay on top-left area
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              child: CustomPaint(
                painter: GlitterPainter(
                  positions: glitterPositions,
                  radii: glitterRadii,
                ),
                size: Size(150, 150),
              ),
            ),

            // Thin vertical bar
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              child: Container(
                width: 10,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFEFAD18), Color(0xFFF8D7B4)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),

            // Image inside the container
            Positioned(
              top: 30,
              left: 10,
              child: Image.asset(
                'assets/heelsbanner.png',
                width: 160,
                height: 160,
              ),
            ),

            // Text and Button
            Positioned(
              top: 50,
              right: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Flat and Heels",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text("Stand a chance to get rewarded"),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Color(0xFFF83758),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('View all', style: TextStyle(color: Colors.white)),
                        SizedBox(width: 5),
                        Icon(Icons.arrow_right_alt, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GlitterPainter extends CustomPainter {
  final List<Offset> positions;
  final List<double> radii;

  GlitterPainter({required this.positions, required this.radii});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Color(0xFFEFAD18)
          ..style = PaintingStyle.fill;

    for (int i = 0; i < positions.length; i++) {
      final path = _createStarPath(
        positions[i].dx,
        positions[i].dy,
        radii[i],
        5,
      );
      canvas.drawPath(path, paint);
    }
  }

  Path _createStarPath(double cx, double cy, double radius, int points) {
    final path = Path();
    final angle = pi / points;

    for (int i = 0; i < 2 * points; i++) {
      final r = (i % 2 == 0) ? radius : radius / 2;
      final x = cx + r * cos(i * angle);
      final y = cy + r * sin(i * angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
