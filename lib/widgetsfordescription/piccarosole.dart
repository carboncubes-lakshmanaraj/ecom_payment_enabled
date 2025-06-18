// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductpicCar extends StatefulWidget {
  const ProductpicCar({Key? key, required this.allimages}) : super(key: key);
  final List<String> allimages;

  @override
  State<ProductpicCar> createState() => _ProductpicCarState();
}

class _ProductpicCarState extends State<ProductpicCar> {
  int activeIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          carouselController: _controller,
          itemCount: widget.allimages.length,
          itemBuilder: (context, index, realIndex) {
            final image = widget.allimages[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            );
          },
          options: CarouselOptions(
            height: 200,
            onPageChanged:
                (index, reason) => setState(() => activeIndex = index),
            viewportFraction: 1,
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Center(
            child: AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: widget.allimages.length,
              effect: WormEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: Colors.blue,
              ),
            ),
          ),
        ),
        if (activeIndex > 0)
          Positioned(
            left: 10,
            top: 80,
            child: FloatingActionButton.small(
              heroTag: "backBtn",
              onPressed: () => _controller.previousPage(),
              child: Icon(Icons.arrow_back),
            ),
          ),
        if (activeIndex < widget.allimages.length - 1)
          Positioned(
            right: 10,
            top: 80,
            child: FloatingActionButton.small(
              heroTag: "forwardBtn",
              onPressed: () => _controller.nextPage(),
              child: Icon(Icons.arrow_forward),
            ),
          ),
      ],
    );
  }
}
