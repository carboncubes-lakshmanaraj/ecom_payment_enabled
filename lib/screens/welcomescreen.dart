import 'package:ecom_payment/screens/homepage.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen size to calculate aspect ratio
    final screenWidth = MediaQuery.of(context).size.width;
    final aspectRatio = 0.462;
    final containerHeight = screenWidth / aspectRatio;

    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 480),
        margin: const EdgeInsets.symmetric(horizontal: 0),
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'assets/welcomescreenimage/welcomeimage.png', // Replace with your actual image path
                fit: BoxFit.cover,
              ),
            ),

            // Black gradient overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(0, 0, 0, 0),
                      const Color.fromARGB(113, 0, 0, 0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            // Content container
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: containerHeight * 0.55,
                ), // Approximate position based on the original design
                // Bottom content section
                Padding(
                  padding: const EdgeInsets.only(
                    left: 55,
                    right: 55,
                    bottom: 34,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Main heading
                      Text(
                        'You want Authentic, here you go!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.34,
                        ),
                      ),

                      // Subtitle
                      Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Text(
                          'Find it here, buy it now!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFFF2F2F2),
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                            height: 2,
                            letterSpacing: 0.14,
                          ),
                        ),
                      ),

                      // Get Started button
                      Padding(
                        padding: const EdgeInsets.only(top: 44),
                        child: ElevatedButton(
                          onPressed: () {
                            // Add navigation logic here
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => Homepage(),
                              ),
                              (Route<dynamic> route) =>
                                  false, // remove all previous routes
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF83758),
                            minimumSize: const Size(double.infinity, 55),
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
