import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pasabuy/models/userdata.dart';

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

      CollectionReference users = FirebaseFirestore.instance.collection('users');

      await users.doc(userCredential.user!.uid).set({
        'name': userdata.name,
        'age': userdata.age,
        'phone': userdata.phone,
      });

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
    var userDoc = await FirebaseFirestore.instance.collection('Users').doc(User().uid).get();
    print('Name : ${User().uid}');
    return userDoc.data()?['name'] ?? 'Null';
  }
}
