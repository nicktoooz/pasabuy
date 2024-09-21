import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pasabuy/models/user.dart';

class MessagePage extends StatefulWidget {
  final String uid;
  const MessagePage({super.key, required this.uid});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  Map<String, String> messages = {};
  @override
  void initState() {
    super.initState();
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference ref = database.ref('Messages/${User().uid}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [],
      ),
    ));
  }
}
