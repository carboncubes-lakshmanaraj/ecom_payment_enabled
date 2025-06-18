import 'package:ecom_payment/screens/loginscreen.dart';
import 'package:ecom_payment/screens/welcomescreen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid - proceed with login logic
      final email = _emailController.text;
      final password = _passwordController.text;
      final confirmPassword = _confirmPasswordController.text;

      print('Login with $email / $password/$confirmPassword');
      // You can now send this to your backend or auth logic
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
      (Route<dynamic> route) => false, // remove all previous routes
    );
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
                'Create an \naccount',
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
              SizedBox(height: 33),
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
                            labelText: 'Username or Email',
                            prefixIcon: Icon(Icons.person),
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

                      const SizedBox(height: 32),
                      SizedBox(
                        width: 317,
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor:
                                Colors.grey.shade200, // Light grey background
                            floatingLabelStyle: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),

                              ///floatlabel color
                            ),
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
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

                      const SizedBox(height: 32),
                      SizedBox(
                        width: 317,
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor:
                                Colors.grey.shade200, // Light grey background
                            floatingLabelStyle: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),

                              ///floatlabel color
                            ),
                            labelText: 'ConfirmPassword',
                            prefixIcon: Icon(Icons.lock),
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
                              ? 'Enter your password correctly'
                              : null,
                        ),
                      ),
                      SizedBox(height: 19),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                            ), // default text style
                            children: [
                              TextSpan(
                                text: "By clicking the ",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 12,

                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: "Register",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 12,

                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFF83758),
                                ), // different color
                              ),
                              TextSpan(
                                text: " button, you agree to the public offer",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 12,

                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
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
                          'Create Account',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 70),
              Center(child: Text("-OR Continue with-")),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Colors
                        .transparent, // Transparent background to show image
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(
                      onTap: () {
                        // Handle tap
                      },
                      borderRadius: BorderRadius.circular(50),
                      splashColor: Colors.pink.withOpacity(
                        0.3,
                      ), // Custom splash color
                      child: Ink(
                        width: 60, // size of the button
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(50),
                          // Ensure the image is sized properly
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/google_log.png', // your image path
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover, // to fit the image inside
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Material(
                    color: Colors
                        .transparent, // Transparent background to show image
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(
                      onTap: () {
                        // Handle tap
                      },
                      borderRadius: BorderRadius.circular(50),
                      splashColor: Colors.pink.withOpacity(
                        0.3,
                      ), // Custom splash color
                      child: Ink(
                        width: 60, // size of the button
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(50),
                          // Ensure the image is sized properly
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/apple _log.png', // your image path
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover, // to fit the image inside
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Material(
                    color: Colors
                        .transparent, // Transparent background to show image
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(
                      onTap: () {
                        // Handle tap
                      },
                      borderRadius: BorderRadius.circular(50),
                      splashColor: Colors.pink.withOpacity(
                        0.3,
                      ), // Custom splash color
                      child: Ink(
                        width: 60, // size of the button
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(50),
                          // Ensure the image is sized properly
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/facebook_log.png', // your image path
                            width: 24,
                            height: 24,
                            fit: BoxFit.contain, // to fit the image inside
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("I Already Have An Account"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) =>
                            false, // remove all previous routes
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFFF83758),
                        color: Color(0xFFF83758),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
