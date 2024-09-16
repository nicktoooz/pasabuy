import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pasabuy/models/user.dart';

class FirebaseDatabaseInstance {
  late FirebaseDatabase _database;

  FirebaseDatabaseInstance() {
    final firebaseApp = Firebase.app();
    _database = FirebaseDatabase.instanceFor(
      app: firebaseApp,
      databaseURL: dotenv.env['DATABASE_URL'],
    );
    if (!kIsWeb) _database.setPersistenceEnabled(true);
    _database.ref('users/${User().uid}').keepSynced(true);
  }
  FirebaseDatabase get database => _database;
}
