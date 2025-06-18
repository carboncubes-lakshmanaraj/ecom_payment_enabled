import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselProductsOff extends StatefulWidget {
  @override
  _CarouselProductsOffState createState() => _CarouselProductsOffState();
}

class _CarouselProductsOffState extends State<CarouselProductsOff> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 270,
          width: double.infinity,
          child: PageView(
            controller: _controller,
            children: [
              _buildPage(
                textTitle: '50-40% OFF',
                descripAdd: 'Now in *(product)',
                textDescrip: 'all colors',
                imagePath: "assets/home/off.png",
              ),
              _buildPage(
                textTitle: '50-40% OFF',
                descripAdd: 'Now in *(product)',
                textDescrip: 'all colors',
                imagePath: "assets/home/off.png",
              ),
              _buildPage(
                textTitle: '50-40% OFF',
                descripAdd: 'Now in *(product)',
                textDescrip: 'all colors',
                imagePath: "assets/home/off.png",
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        SmoothPageIndicator(
          controller: _controller,
          count: 3,
          effect: WormEffect(
            dotHeight: 10,
            dotWidth: 10,
            activeDotColor: Colors.deepPurple,
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildPage({
    required String textTitle,
    required String textDescrip,
    required String descripAdd,
    required String imagePath,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            Image.asset(imagePath, fit: BoxFit.cover),

            // Overlay with text and button
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: const Color.fromARGB(24, 0, 0, 0), // dark overlay
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textTitle,
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  Text(
                    textDescrip,
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  Text(
                    descripAdd,
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      foregroundColor: Colors.white,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Shop Now', style: TextStyle(color: Colors.white)),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_right_alt,
                          color: Colors.white,
                          size: 30,
                        ),
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
