import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pasabuy/models/userdata.dart';
import 'package:pasabuy/utils/firebasedatabase.dart';

class User {
  late FirebaseAuth _auth;
  late String _uid;
  late String _email;
  late String _displayName;
  late bool _authenticated;

  String get uid => _uid;
  String get email => _email;
  String get displayName => _displayName;
  bool get authenticated => _authenticated;

  User() {
    _auth = FirebaseAuth.instance;
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    var user = _auth.currentUser;
    if (user != null) {
      _uid = user.uid;
      _email = user.email ?? '';
      _displayName = user.displayName ?? '';
      _authenticated = true;
    } else {
      _uid = '';
      _email = '';
      _displayName = '';
      _authenticated = false;
    }
  }

  static Future<User> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return User._fromUserCredential(userCredential);
    } catch (e) {
      rethrow;
    }
  }

  static Future<User> signUp(UserData userdata) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userdata.email, password: userdata.password);

      DatabaseReference ref =
          FirebaseDatabaseInstance().database.ref("users/${userCredential.user!.uid.toString()}");

      await ref.set({'name': userdata.name, 'age': userdata.age, 'phone': userdata.phone});
      return User();
    } catch (e) {
      rethrow;
    }
  }

  User._fromUserCredential(UserCredential userCredential) {
    _auth = FirebaseAuth.instance;
    _uid = userCredential.user?.uid ?? '';
    _email = userCredential.user?.email ?? '';
    _displayName = userCredential.user?.displayName ?? '';
    _authenticated = true;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<String> get name async {
    var ref = FirebaseDatabaseInstance().database.ref('users/${User().uid}');
    var userdata = await ref.get();
    return userdata.child('name').value.toString();
  }
}
