import 'package:ecom_payment/alertdialog/dialog_box_time.dart';
import 'package:ecom_payment/currencyprovider/currency_provider.dart';
import 'package:ecom_payment/datas/dummydata.dart';
import 'package:ecom_payment/datas/product.dart';
import 'package:ecom_payment/repositories/currencydao.dart';
import 'package:ecom_payment/repositories/product.dart';
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
import 'package:provider/provider.dart';
import 'package:ecom_payment/cartprovider/cart_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> products = [];
  bool isLoading = true;

  List<String> currencies = [];
  String? selectedCurrency;

  @override
  void initState() {
    super.initState();
    loadCurrencies();
    fetchProducts();
  }

  Future<void> loadCurrencies() async {
    final result = await CurrencyDao.getAllCurrencies();

    setState(() {
      currencies = result;
      selectedCurrency = result.isNotEmpty ? result.first : "INR";
    });
  }

  Future<void> fetchProducts() async {
    final result = await ProductDao.getAllProducts();

    print("Fetched products from DB: ${result.length}");
    for (var p in result) {
      print("""
-------------------
Title: ${p.title}
DealsOfTheDay: ${p.dealsOfTheDay}
MRP: ${p.mrpPrice}
% Off: ${p.percentageOff}
Image: ${p.productImage}
""");
    }
    setState(() {
      products = result;
      isLoading = false;
    });
  }

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
          title: Row(
            children: [
              Image.asset('assets/splash.png', height: 40),
              const SizedBox(width: 12),
              if (currencies.isNotEmpty)
                Expanded(
                  child: Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      final cartNotEmpty = cartProvider.cart.isNotEmpty;

                      return GestureDetector(
                        onTap: () {
                          if (cartNotEmpty) {
                            showThumbsUpDialog(
                              context,
                              'Cannot change currency while cart has items.',
                              isSuccess: false,
                            );
                          }
                        },
                        child: AbsorbPointer(
                          absorbing: cartNotEmpty,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedCurrency,
                              isExpanded: true,
                              items: currencies.map((cur) {
                                return DropdownMenuItem(
                                  value: cur,
                                  child: Text(
                                    cur,
                                    style: TextStyle(fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    selectedCurrency = value;
                                  });
                                  context.read<CurrencyProvider>().setCurrency(
                                    value,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
          centerTitle: false,
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  splashColor: Colors.grey.withOpacity(0.3),
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
                      color: Colors.white,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/pro_pic.png',
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
                child: HorizontalListWithButtons(
                  products: products,
                  selectedCurrency: selectedCurrency,
                ),
              ),
              SizedBox(height: 16),
              NofuncBanner(),
              SizedBox(height: 16),
              GlitterContainer(),
              SizedBox(height: 16),

              TrendingProductbanner(),
              SizedBox(height: 16),
              // SizedBox(
              //   height: 350, //  Set a fixed height for horizontal list!
              //   // child: TrendingProductsHorizontalListWithButtons(
              //   //   selectedCurrency: selectedCurrency,
              //   //   products: products,
              //   // ),
              // ),
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
