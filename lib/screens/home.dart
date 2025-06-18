import 'package:ecom_payment/datas/dummydata.dart';
import 'package:ecom_payment/widgetsforhome/sponseredcard.dart';
import 'package:ecom_payment/widgetsforhome/glittercontainerheelsbanner.dart';
import 'package:ecom_payment/widgetsforhome/newarrivalcard.dart';
import 'package:ecom_payment/widgetsforhome/testsortedandfilterbuttons.dart';
import 'package:ecom_payment/widgetsforhome/trendingproductbanner.dart';
import 'package:ecom_payment/widgetsforhome/TrendingProductsHorizontalListWithButtons.dart';
import 'package:ecom_payment/widgetsforhome/dealofdaytimer.dart';
import 'package:ecom_payment/widgetsforhome/dealofthedayproductshorizontallist.dart';
import 'package:ecom_payment/widgetsforhome/nofuncbanner.dart';
import 'package:ecom_payment/widgetsforhome/carousel_products_off_disp.dart';
import 'package:ecom_payment/widgetsforhome/category_round_nav_bar.dart';
import 'package:ecom_payment/widgetsforhome/searchbar_with_aud.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            children: [
              SearchbarWithAud(),
              SizedBox(height: 16),
              SortedandFiltered(),
              SizedBox(height: 26),
              CategoryRoundNavBar(),
              SizedBox(height: 16),
              CarouselProductsOff(),
              SizedBox(height: 16),
              DealOfTheDay(endTime: endDate),
              SizedBox(height: 16),
              SizedBox(
                height: 350, //  Set a fixed height for horizontal list!
                child: HorizontalListWithButtons(products: dummyProducts),
              ),
              SizedBox(height: 16),
              NofuncBanner(),
              SizedBox(height: 16),
              GlitterContainer(),
              SizedBox(height: 16),

              TrendingProductbanner(),
              SizedBox(height: 16),
              SizedBox(
                height: 350, //  Set a fixed height for horizontal list!
                child: TrendingProductsHorizontalListWithButtons(
                  products: dummyProducts,
                ),
              ),
              SizedBox(height: 16),

              NewArrivalsCard(),
              SizedBox(height: 16),
              SponserdCard(),
            ],
          ),
        ),
      ),
    );
  }
}
