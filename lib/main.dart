import 'package:ecom_payment/stripekeys/keys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart'; // ✅ Add this line

import 'package:ecom_payment/cartprovider/cart_provider.dart';
import 'package:ecom_payment/screens/spalshscreen.dart';
import 'package:ecom_payment/dbmanager/db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Stripe with your publishable key
  Stripe.publishableKey = publishableKey; // <-- Replace with your key
  await Stripe.instance.applySettings();

  // ✅ Initialize your SQLite DB
  await DBManager.database;

  runApp(ChangeNotifierProvider(create: (_) => CartProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Montserrat'),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


///////////////////////////////////////////////////////


// import 'package:flutter/material.dart';

// void main() => runApp(FlipkartStyleApp());

// class FlipkartStyleApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flipkart UI',
//       home: FlipkartHomePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class FlipkartHomePage extends StatelessWidget {
//   final List<String> banners = [
//     'https://via.placeholder.com/400x150?text=Banner+1',
//     'https://via.placeholder.com/400x150?text=Banner+2',
//   ];

//   final List<Map<String, String>> categories = [
//     {'name': 'Mobiles', 'icon': '📱'},
//     {'name': 'Fashion', 'icon': '👗'},
//     {'name': 'Electronics', 'icon': '💻'},
//     {'name': 'Home', 'icon': '🏠'},
//     {'name': 'Beauty', 'icon': '💄'},
//   ];

//   final List<Map<String, String>> products = List.generate(
//     10,
//     (index) => {
//       'name': 'Product $index',
//       'price': '₹${999 + index * 100}',
//       'image': 'https://via.placeholder.com/150?text=Product+$index',
//     },
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Flipkart UI Clone"),
//         backgroundColor: Colors.blue,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Banners
//             SizedBox(
//               height: 150,
//               child: PageView.builder(
//                 itemCount: banners.length,
//                 itemBuilder:
//                     (_, i) => Image.network(banners[i], fit: BoxFit.cover),
//               ),
//             ),

//             // Categories
//             Padding(
//               padding: EdgeInsets.all(8),
//               child: Text(
//                 "Top Categories",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(
//               height: 90,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: categories.length,
//                 itemBuilder: (_, i) {
//                   return Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 12),
//                     child: Column(
//                       children: [
//                         CircleAvatar(
//                           radius: 25,
//                           child: Text(
//                             categories[i]['icon']!,
//                             style: TextStyle(fontSize: 24),
//                           ),
//                         ),
//                         SizedBox(height: 5),
//                         Text(categories[i]['name']!),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),

//             // Deals of the Day / Grid
//             Padding(
//               padding: EdgeInsets.all(8),
//               child: Text(
//                 "Deals of the Day",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             GridView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               padding: EdgeInsets.all(8),
//               itemCount: products.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.7,
//                 crossAxisSpacing: 8,
//                 mainAxisSpacing: 8,
//               ),
//               itemBuilder: (_, i) {
//                 return Card(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Image.network(
//                         products[i]['image']!,
//                         height: 100,
//                         fit: BoxFit.cover,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(8),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               products[i]['name']!,
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               products[i]['price']!,
//                               style: TextStyle(color: Colors.green),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
