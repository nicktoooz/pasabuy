import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Firestore {
  late FirebaseFirestore _database;

  Firestore() {
    final firebaseApp = Firebase.app();
    _database = FirebaseFirestore.instance;
  }
  FirebaseFirestore get database => _database;
}
