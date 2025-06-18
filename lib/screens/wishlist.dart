import 'package:ecom_payment/widgetsforhome/searchbar_with_aud.dart';
import 'package:ecom_payment/widgetsforwishlist/sortedandfilforwishlist.dart';
import 'package:ecom_payment/widgetsforwishlist/staggergridwishlist.dart';
import 'package:flutter/material.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
      bottom: 80, // Keep above FAB
      left: 20,
      right: 20,
    ),
    content: Text('button pressed'),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque, // Ensures all taps are detected
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss keyboard
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false, // prevents FAB from shifting
        drawer: Drawer(
          child: ListView(
            children: const [
              DrawerHeader(child: Text("Header")),
              ListTile(title: Text("Item 1")),
              // Add more items here
            ],
          ),
        ),
        appBar: AppBar(
          title: Image.asset(
            'assets/splash.png', // Path to your PNG image
            height: 40, // Adjust as needed
          ),
          centerTitle: true, // Optional: center the image
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),

          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Material(
                color: Colors.transparent, // This ensures splash effect works
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  splashColor: Colors.grey.withOpacity(
                    0.3,
                  ), // Optional: custom splash color
                  onTap: () {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors
                          .white, // Background color (white or whatever you like)
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/pro_pic.png', // Make sure the image path is correct
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [SearchbarWithAud(), SortedandFilteredWL(), Wishlist()],
          ),
        ),
      ),
    );
  }
}
