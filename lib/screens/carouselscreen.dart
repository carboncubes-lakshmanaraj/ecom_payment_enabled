import 'package:ecom_payment/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselScreen extends StatefulWidget {
  @override
  _CarouselScreenState createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  final CarouselSliderController _carouselController =
      CarouselSliderController(); //for manual control over carosol

  int _currentIndex = 0;

  final List<Map<String, String>> slides = [
    {
      'image': 'assets/images/slide1.png',
      'title': 'Choose Products',
      'text':
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    },

    {
      'image': 'assets/images/slide2.png',
      'title': 'Make Payment',
      'text':
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    },

    {
      'image': 'assets/images/slide3.png',
      'title': 'Get Your Order',
      'text':
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///////////app bar ,page number//////////////////////
      appBar: AppBar(
        backgroundColor: Colors.white, // White background for the AppBar
        elevation: 0, // Removes shadow below the AppBar
        /////////////skip button///////////////
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
            child: Text(
              'Skip',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Montserrat',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],

        ///////////////////////////////////////page number////////
        title: Row(
          children: [
            Text(
              '${_currentIndex + 1}',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Montserrat',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '/${slides.length}',
              style: TextStyle(
                color: const Color(0xFFA0A0A1),
                fontFamily: 'Montserrat',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,

      //////////////////////////////////////
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CarouselSlider(
                    carouselController: _carouselController,
                    items: slides.map((slide) {
                      return Builder(
                        builder: (context) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 250,
                              height: 250,
                              child: Image.asset(
                                slide['image']!,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 30),
                            Text(
                              slide['title']!,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Montserrat',
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              slide['text']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFFA8A8A9),
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 24 / 14, // lineHeight equivalent
                                letterSpacing: 0.28,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.75,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),

          /// Bottom Dot Indicator
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Previous Button (hidden but space preserved)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Visibility(
                    visible: _currentIndex > 0,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: const Color.fromRGBO(196, 196, 196, 1),
                      ),

                      onPressed: () {
                        _carouselController.previousPage();
                      },
                      child: Text(
                        'Prev',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                // Add other buttons here, e.g. Next

                // Dots Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _currentIndex < slides.length - 1
                      ? List.generate(slides.length, (index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            width: _currentIndex == index ? 12 : 8,
                            height: _currentIndex == index ? 12 : 8,
                            decoration: BoxDecoration(
                              color: _currentIndex == index
                                  ? Colors.black
                                  : Colors.grey[400],
                              shape: BoxShape.circle,
                            ),
                          );
                        })
                      : List.empty(),
                ),

                // Next Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(248, 55, 88, 1),
                    ),
                    onPressed: _currentIndex < slides.length - 1
                        ? () {
                            _carouselController.nextPage();
                          }
                        : () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                            );
                          },
                    child: Center(
                      child: Text(
                        _currentIndex < slides.length - 1
                            ? 'Next'
                            : 'Get Started',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                // Show button only on last slide
              ],
            ),
          ),
        ],
      ),
    );
  }
}
