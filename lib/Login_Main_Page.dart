import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'Home_Page.dart';
import 'Registration_Page.dart';
import 'localizedstrings.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _isEmailValid = false;
  final _passwordFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  bool _isPasswordObscured = true; // State variable to track password visibility



  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
padding: const EdgeInsets.all(20),
            child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
            children:[
            const CircleAvatar(
              backgroundImage: AssetImage('assets/imglogo.png'),
              backgroundColor: Colors.white,
              radius: 100,
            ),
      Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Please enter your email address",
                      prefixIcon: Icon(Icons.mail, color: AppStrings.themecolor1),

                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }
                      if (!isValidEmail(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      setState(() {
                        _isEmailValid = _formKey.currentState!.validate();
                      });
                      if (_isEmailValid) {
                        _emailFocusNode.unfocus(); //for hide the keyboard
                        FocusScope.of(context).requestFocus(_passwordFocusNode);//for focus on next field
                      }
                    },

                  ),
                ),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    keyboardType: TextInputType.text,
                    obscureText: _isPasswordObscured,
                   // enabled: _isEmailValid,
                    decoration: InputDecoration(
                      hintText: "Please enter your password",
                      prefixIcon:Icon(Icons.lock, color: AppStrings.themecolor1),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                          color: _isPasswordObscured ? Colors.indigoAccent:Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordObscured = !_isPasswordObscured;
                          });
                        },
                      ),
                      // enabledBorder: _isEmailValid
                      //     ? null
                      //     : const OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.grey),
                      // ),
                    ),
                    validator: (value) {
                      if (_isEmailValid) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        // Add additional password validation if needed
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      // Hide the keyboard
                      _passwordFocusNode.unfocus();
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: SizedBox(
                    width: 200,
                    child: RawMaterialButton(
                      fillColor: AppStrings.themecolor1,
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, perform login operation
                          // You can access the email and password using _emailController.text and _passwordController.text respectively
                          await performLogin(context);
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: SizedBox(
                      child: Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          child: RichText(
                            text: TextSpan(
                              text: 'Register',
                              style: TextStyle(color: Colors.blue,fontSize: 20),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()),
                                  );
                                },
                            ),
                          ),
                        ),
                      )
                  ),
                )
              ],
            ),
      ),
        ]
      ),
        ),
      )
    )
    );
  }

bool isValidEmail(String value) {
  final RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z\d-]{2,}$',
  );
  return emailRegex.hasMatch(value);
}

  Future<void> performLogin(BuildContext context) async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      // Authenticate the user using Firebase Authentication
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value){
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageSections()),);

      });

      // Login successful, navigate to the next page
    } catch (e) {

      // Handle login errors and show error message
      String errorMessage = 'An error occurred during login.';
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          errorMessage = 'Invalid email or password.';
        }

      }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => const HomePageSections(),
            ),
          ],
        )

      );
      print('Login Error: $e');

    }
  }

// Remaining code...
}

