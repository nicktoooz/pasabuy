import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseDatabaseInstance {
  late FirebaseDatabase _database;

  FirebaseDatabaseInstance() {
    final firebaseApp = Firebase.app();
    _database = FirebaseDatabase.instanceFor(
      app: firebaseApp,
      databaseURL: dotenv.env['DATABASE_URL'],
    );
  }
  FirebaseDatabase get database => _database;
}
