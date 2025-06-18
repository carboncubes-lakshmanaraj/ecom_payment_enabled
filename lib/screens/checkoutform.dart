// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom_payment/screens/buynowforoneproduct.dart';
import 'package:flutter/material.dart';

import 'package:ecom_payment/datas/product.dart';
import 'package:ecom_payment/widgetsforcheckoutform/pofilepicedit.dart';

class Checkoutform extends StatefulWidget {
  const Checkoutform({Key? key, required this.product, required this.size})
    : super(key: key);
  final Product product;
  final String size;

  @override
  State<Checkoutform> createState() => _CheckoutformState();
}

class _CheckoutformState extends State<Checkoutform> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  bool _isAccountVisible = true;
  String _fullAccountNumber = '';
  final TextEditingController _accountController = TextEditingController();
  final FocusNode _accountFocusNode = FocusNode();

  String? selectedState;

  List<String> states = ['State 1', 'State 2', 'State 3'];

  void submit() {}
  String _maskAccount(String value) {
    if (value.length <= 4) return value;
    return value.substring(0, 4) + 'X' * (value.length - 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout"), centerTitle: true),

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 317,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfilePictureWithEdit(
                      assetPath: "assets/pro_pic.png",
                      onEdit: () {
                        print('Edit tapped');
                      },
                    ),
                  ],
                ),
                SizedBox(height: 50),
                // Here's the fix
                Text(
                  "Personal Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text("Email Address"),
                SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 317,
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Username or Email',

                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!value.contains('@')) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      Text("Password"),
                      SizedBox(height: 16),
                      SizedBox(
                        width: 317,
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',

                            suffixIcon: IconButton(
                              onPressed: () {}, // TODO: add toggle logic
                              icon: Icon(Icons.remove_red_eye_outlined),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Enter your password'
                              : null,
                        ),
                      ),
                      Row(
                        children: [
                          Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Change Password',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 16,
                                color: Colors.blue, // optional: customize color
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Divider(),
                      SizedBox(height: 16),
                      // Here's the fix
                      Text(
                        "Business Address Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ), // New Fields for Address, City, State, Country
                      SizedBox(height: 16),
                      Text("Pincode"),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 317,
                        child: TextFormField(
                          controller: _pincodeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter Pincode',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the pincode';
                            } else if (int.tryParse(value) == null) {
                              return 'Pincode must be an integer';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      Text("Address"),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 317,
                        child: TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            hintText: 'Enter Address',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the address';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      Text("City"),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 317,
                        child: TextFormField(
                          controller: _cityController,
                          decoration: InputDecoration(
                            hintText: 'Enter City',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the city';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      Text("State"),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 317,
                        child: DropdownButtonFormField<String>(
                          value: selectedState,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          items: states
                              .map(
                                (state) => DropdownMenuItem<String>(
                                  value: state,
                                  child: Text(state),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedState = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a state';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      Text("Country"),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 317,
                        child: TextFormField(
                          controller: _countryController,
                          decoration: InputDecoration(
                            hintText: 'Enter Country',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the country';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      Divider(),
                      SizedBox(height: 16),
                      Text(
                        "Bank Account Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      // Account Number
                      Text("Account Number"),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 317,
                        child: TextFormField(
                          controller: _accountController,
                          focusNode: _accountFocusNode,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter Account Number',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isAccountVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isAccountVisible = !_isAccountVisible;
                                  _accountController.text = _isAccountVisible
                                      ? _fullAccountNumber
                                      : _maskAccount(_fullAccountNumber);
                                  _accountController
                                      .selection = TextSelection.fromPosition(
                                    TextPosition(
                                      offset: _accountController.text.length,
                                    ),
                                  );
                                });
                              },
                            ),
                          ),
                          onChanged: (value) {
                            _fullAccountNumber = value;
                          },
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus(); // Hide keyboard
                            setState(() {
                              if (!_isAccountVisible) {
                                _accountController.text = _maskAccount(
                                  _fullAccountNumber,
                                );
                              }
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter account number';
                            }
                            if (_fullAccountNumber.length < 6) {
                              return 'Account number too short';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16),

                      // Account Holder’s Name
                      Text("Account Holder’s Name"),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 317,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter Name as per Bank',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter account holder name';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16),

                      // IFSC Code
                      Text("IFSC Code"),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 317,
                        child: TextFormField(
                          textCapitalization: TextCapitalization.characters,
                          decoration: InputDecoration(
                            hintText: 'Enter IFSC Code',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter IFSC code';
                            }
                            if (!RegExp(
                              r'^[A-Z]{4}0[A-Z0-9]{6}$',
                            ).hasMatch(value)) {
                              return 'Invalid IFSC code format'; //SBIN0005943
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: SizedBox(
                          width: 317,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              // if (_formKey.currentState!.validate()) {
                              //   // You can call your submit logic here
                              //   submit();
                              // }
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PlaceOrderScreen(
                                    product: widget.product,
                                    size: widget.size,
                                  ),
                                  // (context) => Buynowforoneitem(
                                  //   product: widget.product,
                                  //   size: widget.size,
                                  // ), //////////////////----------------------------
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(
                                0xFFF83758,
                              ), // Button color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ), // Rounded corners
                              ),
                            ),
                            child: Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white, // Text color
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
