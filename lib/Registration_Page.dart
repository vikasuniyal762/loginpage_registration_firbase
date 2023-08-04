import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'localizedstrings.dart';

class RegistrationPage extends StatefulWidget {

  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  bool _isEmailValid = false;
  bool _isUserNameValid = false;
  bool _isMobileValid = false;
  bool _showUserNameHelperText = false;
  bool _showEmailHelperText = false;
  bool _isPasswordObscured = true; // Initialize to true for password obscured


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _userNameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  bool _validateUserName(String value) {
    if (value.isEmpty) {
      return false;
    }
    if (!isUserNameValid(value)) {
      return false;
    }
    return true;
  }

  bool _validateEmail(String value) {
    if (value.isEmpty) {
      return false;
    }
    if (!isValidEmail(value)) {
      return false;
    }
    return true;
  }

  bool _validateMobileNum(String value) {
    if (value.isEmpty) {
      return false;
    }
    if (!isMobileNumValid(value)) {
      return false;
    }
    return true;
  }

  bool _validatePassword(String value) {
    if (value.isEmpty) {
      return false;
    }
      // final RegExp passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    final RegExp passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return passwordRegex.hasMatch(value);
  }

  bool _validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return false;
    }
    return value == _passwordController.text;
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
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/imglogo.png'),
                  backgroundColor: Colors.white,
                  radius: 100,
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _userNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "User Name",
                          prefixIcon: Icon(
                            Icons.account_circle,
                            color: AppStrings.themecolor1,
                          ),
               //            suffixIcon: GestureDetector(
               //              onTap: () {
               //                setState(() {
               //                  _showUserNameHelperText = !_showUserNameHelperText;
               //                });
               //              },
               //              child: Icon(
               //                _showUserNameHelperText ? Icons.info_outline : Icons.info_outline,
               //                color: _showUserNameHelperText ? Colors.red :Colors.green
               //              ),
               //            ),
               //            helperText: _showUserNameHelperText
               //                ? '''Username should be 4 to 20 characters long and may contain letters,
               // numbers, and underscores'''
               //                : null,
                        ),
                        validator: (value) {
                          if (!_validateUserName(value ?? "")) {
                            return 'Please enter a valid user name';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          _formKey.currentState!.validate();
                          setState(() {
                            _isUserNameValid = _validateUserName(_userNameController.text);
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Please enter your email address",
                          prefixIcon: Icon(
                            Icons.mail,
                            color: AppStrings.themecolor1,
                          ),
                          // suffixIcon: GestureDetector(
                          //   onTap: () {
                          //     setState(() {
                          //       _showEmailHelperText = !_showEmailHelperText;
                          //     });
                          //   },
                          //   child: Icon(
                          //     _showEmailHelperText ? Icons.info_outline : Icons.info_outline,
                          //     color: _showEmailHelperText ? Colors.red :Colors.green
                          //   ),
                          // ),
                          // helperText: _showEmailHelperText
                          //     ? '''Please enter a valid email address like :example123@example.com'''
                          //     : null,
                        ),
                        validator: (value) {
                          if (!_validateEmail(value ?? "")) {
                            return 'Please enter a valid email address like :example123@example.com';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          _formKey.currentState!.validate();
                          setState(() {
                            _isEmailValid = _validateEmail(_emailController.text);
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _mobileController,
                        keyboardType: TextInputType.phone,
                        // enabled: _isEmailValid,
                        decoration: const InputDecoration(
                          hintText: "Please enter your mobile number",
                          prefixIcon: Icon(
                            Icons.phone,
                            color: AppStrings.themecolor1,
                          ),
                        ),
                        validator: (value) {
                          if (!_validateMobileNum(value ?? "")) {
                            return 'Please enter a valid mobile number';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          _formKey.currentState!.validate();
                          setState(() {
                            _isMobileValid =
                                _validateMobileNum(_mobileController.text);
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      // TextFormField(
                      //   controller: _passwordController,
                      //   keyboardType: TextInputType.text,
                      //   obscureText: true,
                      //   // enabled: _isMobileValid,
                      //   decoration: const InputDecoration(
                      //     hintText: "Please enter your password",
                      //     prefixIcon: Icon(
                      //       Icons.lock,
                      //       color: AppStrings.themecolor1,
                      //     ),
                      //   ),
                      //   validator: (value) {
                      //     if (_isMobileValid) {
                      //       if (!_validatePassword(value ?? "")) {
                      //         return 'Please enter a valid password';
                      //       }
                      //     }
                      //     return null;
                      //   },
                      //   onFieldSubmitted: (_) {
                      //     _formKey.currentState!.validate();
                      //   },
                      // ),
                      TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: _isPasswordObscured, // Update the obscureText property based on the state variable
                        // enabled: _isMobileValid,
                        decoration: InputDecoration(
                          hintText: "Please enter your password",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: AppStrings.themecolor1,
                          ),
                          suffixIcon: IconButton(
                            // Add a suffix icon button to toggle password visibility
                            icon: _isPasswordObscured ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isPasswordObscured = !_isPasswordObscured;
                              });
                            },
                          ),

                        ),
                        validator: (value) {
                          if (_isMobileValid) {
                            if (!_validatePassword(value ?? "")) {
                              return ''''Password must be 8 characters or more with an uppercase letter, 
a lowercase letter, a digit, and a special character (@!%*?&)''';
                            }
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          _formKey.currentState!.validate();
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _confirmPasswordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        // enabled: _isMobileValid,
                        decoration: InputDecoration(
                          hintText: "Please confirm your password",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: AppStrings.themecolor1,
                          ),
                        ),
                        validator: (value) {
                          if (_isMobileValid) {
                            if (!_validateConfirmPassword(value ?? "")) {
                              return 'Passwords do not match';
                            }
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          _formKey.currentState!.validate();
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: RawMaterialButton(
                          fillColor: AppStrings.themecolor1,
                          onPressed: () async {
                            _formKey.currentState!.validate();
                            if (_isMobileValid &&
                                _isEmailValid &&
                                _isUserNameValid) {
                              await _performRegistration();
                            }
                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
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

  Future<void> _performRegistration() async {

    final email = _emailController.text;
    final password = _passwordController.text;
    final userName = _userNameController.text;
    final mobileNumber = _mobileController.text;

    try {
      // Register the user using Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Save additional registration data to FireStore
      String userId = userCredential.user!.uid;
      Map<String, dynamic> registrationData =
        {
          'userId': userId,
          'email': email,
          'password': password,
          'userName': userName,
          'mobileNumber': mobileNumber,
        };
      FirebaseFirestore.instance.collection('Registration').doc(email).set(registrationData);
      // List <Map<String, dynamic>> registrationData =[
      //   {
      //     'userId': userId,
      //     'email': email,
      //     'password': password,
      //     'userName': userName,
      //     'mobileNumber': mobileNumber,
      //   }
      //   ];
      // FirebaseFirestore.instance.collection('Registration').doc("fields").update({'data': FieldValue.arrayUnion(registrationData),});
    } catch (e) {
      // Handle any errors that occur during the registration process
      print('Error registering user: $e');
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Registration Successful"),
          content: Text("You have successfully registered."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool isValidEmail(String value) {
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z\d-]{2,}$',
    );
    return emailRegex.hasMatch(value);
  }

  // bool isUserNameValid(String input) {
  //   final RegExp userRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
  //   return userRegex.hasMatch(input);
  // }

  bool isUserNameValid(String input) {
    final RegExp userRegex = RegExp(r'^[a-zA-Z\s]{3,20}$');
    return userRegex.hasMatch(input);
  }

  bool isMobileNumValid(String value) {
    final RegExp mobileRegex = RegExp(r'^\d{10}$');
    return mobileRegex.hasMatch(value);
  }
}
