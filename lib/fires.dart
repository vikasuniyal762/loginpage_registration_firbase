// import 'dart:convert';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'firestore_service.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(home: MyWidget()));
// }
//
//
// class MyWidget extends StatefulWidget {
//   @override
//   _MyWidgetState createState() => _MyWidgetState();
// }
//
// class _MyWidgetState extends State<MyWidget> {
//   final FirestoreService firestoreService = FirestoreService();
//   List<dynamic> userData = [];
//
//   fetchData() async {
//     Map<String, dynamic> jsonData = await firestoreService.fetchUserData();
//     List<dynamic> userList = jsonData.values.toList();
//     setState(() {
//       userData = userList;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firestore Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               child: Text('Fetch Data'),
//               onPressed: fetchData,
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: userData.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text('User ${index + 1}'),
//                     subtitle: Text(jsonEncode(userData[index])),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
