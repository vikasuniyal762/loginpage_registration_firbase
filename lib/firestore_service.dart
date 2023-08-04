// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:convert';
//
// class FirestoreService {
//   Future<Map<String, dynamic>> fetchUserData() async {
//     QuerySnapshot<Map<String, dynamic>> snapshot =
//     await FirebaseFirestore.instance.collection('users').get();
//
//     Map<String, dynamic> jsonData = {};
//
//     for (var doc in snapshot.docs) {
//       jsonData[doc.id] = doc.data();
//     }
//
//     String jsonString = json.encode(jsonData);
//     return json.decode(jsonString);
//   }
// }
