import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasabuy/models/user.dart';
import 'package:pasabuy/views/home/home.dart';

class MessageListPage extends StatefulWidget {
  const MessageListPage({super.key});

  @override
  State<MessageListPage> createState() => _MessageListPageState();
}

class _MessageListPageState extends State<MessageListPage> {
  List<String> messageRecepients = [];
  @override
  void initState() {
    super.initState();
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference ref = database.ref('Messages/${User().uid}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Messages"),
            ...messageRecepients.map((e) {
              return ListTile(
                onTap: () {},
                title: Text(e),
              );
            })
          ],
        ),
      ),
    );
  }
}
