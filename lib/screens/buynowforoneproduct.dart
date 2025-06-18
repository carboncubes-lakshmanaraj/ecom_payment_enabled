// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom_payment/datas/product.dart';
import 'package:ecom_payment/screens/testforgateway.dart';
import 'package:flutter/material.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({Key? key, required this.product, required this.size})
    : super(key: key);
  final Product product;
  final String size;
  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  // String? selectedSize = '42'; // Default selected size
  int? selectedQty = 1; // Default selected quantity

  // Size options
  // List<String> sizeOptions = ['38', '40', '42', '44', '46'];

  // Quantity options
  List<int> qtyOptions = [1, 2, 3, 4, 5];

  late String selectedSize;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.size; // Use the passed size
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: const Color.fromARGB(255, 0, 0, 0),
            ), // Heart icon
            onPressed: () {
              // Your logic when the heart button is pressed
              print('Heart icon pressed');
            },
          ),
        ],
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: const Color.fromARGB(255, 0, 0, 0),
          ), // Customize icon and color
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: Text(
          'Shopping Bag',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.41,
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(253, 253, 253, 1),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: 800,
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 480),
                margin: const EdgeInsets.symmetric(horizontal: 16),

                padding: const EdgeInsets.symmetric(vertical: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildProductSection(),
                      _buildCouponSection(),
                      Divider(),
                      _buildOrderPaymentDetails(widget.product),
                    ],
                  ),
                ),
              ),
            ),
            _buildBottomSection(context, widget.product),
          ],
        ),
      ),
    );
  }

  //////////////////////////////////////////the contaniner for the product////
  Widget _buildProductSection() {
    return Container(
      constraints: BoxConstraints(minHeight: 200),

      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                widget.product.productImage,
                width: 123,
                height: 133,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Container(
                  width: 200,
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.title,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.7,
                        ),
                        maxLines: 2, // Limit to 2 lines
                        overflow: TextOverflow
                            .ellipsis, // Adds an ellipsis if the text overflows
                      ),
                      ////////////////
                      ///
                      SizedBox(height: 8),
                      Text(
                        widget.product.productDescrip,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.7,
                        ),
                        maxLines: 2, // Limit to 2 lines
                        overflow: TextOverflow
                            .ellipsis, // Adds an ellipsis if the text overflows
                      ),
                      //////////////////////////////////////
                      SizedBox(height: 10),

                      ///
                      ///
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: 86,
                              height: 25,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(
                                  242,
                                  242,
                                  242,
                                  1,
                                ), //242, 242, 242, 1
                                borderRadius: BorderRadius.circular(8),
                              ),

                              child: Row(
                                ////................
                                children: [
                                  Container(
                                    width: 86,
                                    height: 25,

                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Size: $selectedSize', // Display the selected size here
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  //         DropdownButton<String>(
                                  //           value: selectedSize,
                                  //           onChanged: (String? newValue) {
                                  //             setState(() {
                                  //               selectedSize = newValue!;
                                  //             });
                                  //           },
                                  //           items:
                                  //               sizeOptions
                                  //                   .map<DropdownMenuItem<String>>((
                                  //                     String size,
                                  //                   ) {
                                  //                     return DropdownMenuItem<String>(
                                  //                       value: size,
                                  //                       child: Text(size),
                                  //                     );
                                  //                   })
                                  //                   .toList(),
                                  //           underline: Container(),
                                  //           icon: Icon(
                                  //             Icons.arrow_drop_down,
                                  //             color: Colors.black,
                                  //           ),
                                  //           style: TextStyle(
                                  //             fontFamily: 'Montserrat',
                                  //             fontSize: 14,
                                  //             color: Colors.black,
                                  //             fontWeight: FontWeight.w500,
                                  //             letterSpacing: -1.2,
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(width: 6),
                                  /////another drop down
                                  Container(
                                    width: 86,
                                    height: 25,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                        242,
                                        242,
                                        242,
                                        1,
                                      ), //242, 242, 242, 1
                                      borderRadius: BorderRadius.circular(8),
                                    ),

                                    child: Row(
                                      children: [
                                        Text(
                                          'Qty',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(width: 11),
                                        DropdownButton<int>(
                                          value: selectedQty,
                                          onChanged: (int? newValue) {
                                            setState(() {
                                              selectedQty = newValue!;
                                            });
                                          },
                                          items: qtyOptions
                                              .map<DropdownMenuItem<int>>((
                                                int qty,
                                              ) {
                                                return DropdownMenuItem<int>(
                                                  value: qty,
                                                  child: Text(qty.toString()),
                                                );
                                              })
                                              .toList(),
                                          underline: Container(),
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black,
                                          ),
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: -1.2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            " Delivery by",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.7,
                            ),
                            maxLines: 2, // Limit to 2 lines
                            overflow: TextOverflow
                                .ellipsis, // Adds an ellipsis if the text overflows
                          ),
                          SizedBox(width: 15),
                          Text(
                            "10 May 2XXX",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.7,
                            ),
                            maxLines: 2, // Limit to 2 lines
                            overflow: TextOverflow
                                .ellipsis, // Adds an ellipsis if the text overflows
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////
///apply coupons//////////////////////select/////////////
///
Widget _buildCouponSection() {
  return Padding(
    padding: const EdgeInsets.only(left: 17, right: 17, top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.local_offer_outlined),
        SizedBox(width: 10),
        Text(
          'Apply Coupons',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.7,
          ),
        ),
        Spacer(),
        TextButton(
          child: Text(
            'Select',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
              color: const Color.fromRGBO(248, 55, 88, 1),
              fontWeight: FontWeight.w600,
              letterSpacing: -0.7,
            ),
          ),
          onPressed: () {},
        ),
      ],
    ),
  );
}

//////////////////////////////////////////////////////////////////
Widget _buildOrderPaymentDetails(Product product) {
  return Padding(
    padding: const EdgeInsets.only(left: 17, right: 17),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 34),
          child: Text(
            'Order Payment Details',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.7,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 26),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Amounts',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.7,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        Text(
                          'Convenience',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.7,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Text(
                          'Know More',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            color: const Color.fromRGBO(248, 55, 88, 1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      'Delivery Fee',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.7,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(Icons.currency_rupee_sharp, size: 16),
                      const SizedBox(width: 7),
                      Text(
                        product.discountedPrice.toStringAsFixed(2),
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 19),
                    child: Text(
                      'Apply Coupon',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        color: const Color.fromRGBO(234, 23, 18, 1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 11),
                    child: Text(
                      'Free',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        color: const Color.fromRGBO(248, 55, 88, 1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Container(
            height: 2,
            color: const Color.fromRGBO(202, 202, 202, 1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 29),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Total',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.7,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.currency_rupee_sharp, size: 16),
                  const SizedBox(width: 7),
                  Text(
                    product.discountedPrice.toStringAsFixed(2),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Text(
                'EMI Available ',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.7,
                ),
              ),
              const SizedBox(width: 22),
              Text(
                'Details',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 12,
                  color: const Color.fromRGBO(248, 55, 88, 1),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
//////////////////////////////////////////////////////////bottom card////

Widget _buildBottomSection(BuildContext context, Product product) {
  return Card(
    margin: EdgeInsets.all(10),
    child: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Icon(Icons.currency_rupee_sharp, size: 16),
                  const SizedBox(width: 7),
                  Text(
                    product.discountedPrice.toStringAsFixed(2),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'View Details',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    color: const Color.fromRGBO(234, 23, 18, 1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          ///////////////button///////////////
          Center(
            child: SizedBox(
              width: 219,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Payment(product: product),
                    ),
                  );

                  ///==============
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF83758), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Proceed to Payment',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white, // Text color
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
