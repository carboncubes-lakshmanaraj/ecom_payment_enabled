import 'package:ecom_payment/screens/signupscreen.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid - proceed with login logic
      final email = _emailController.text;

      print('Login with $email ');
      // You can now send this to your backend or auth logic
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot\npassword?',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 36,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  height:
                      43 /
                      36, // lineHeight / fontSize to get the correct height
                ),
              ),
              SizedBox(height: 36),
              Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 317,
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor:
                                Colors.grey.shade200, // Light grey background
                            floatingLabelStyle: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),

                              ///floatlabel color
                            ),
                            labelText: 'Enter your email address',
                            prefixIcon: Icon(Icons.mail),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
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

                      const SizedBox(height: 26),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "* ",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color(0xFFF83758),

                                decorationColor: Color(0xFFF83758),
                              ),
                            ),
                            TextSpan(
                              text:
                                  "We will send you a message to set or reset your new password",
                              style: TextStyle(
                                color: Colors
                                    .black, // or any other text color you want
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 26),
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFFF83758,
                          ), // background color
                          fixedSize: const Size(317, 55), // button size
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ), // adjust for roundness
                          ),
                        ),

                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
