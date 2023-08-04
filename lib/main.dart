import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Login_Main_Page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HELLO ',
      theme: ThemeData(
          primarySwatch: Colors.green
      ),
     // home: SecondPageState(),
      home:const LoginPage(),
    );
  }
}
