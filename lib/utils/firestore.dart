import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  static final Firestore _instance = Firestore._internal();
  late FirebaseFirestore _database;

  Firestore._internal() {
    _initialize();
  }

  factory Firestore() {
    return _instance;
  }

  void _initialize() {
    _database = FirebaseFirestore.instance;
  }

  FirebaseFirestore get instance => _database;
}
