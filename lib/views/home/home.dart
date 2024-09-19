import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasabuy/models/post.dart';
import 'package:pasabuy/utils/firebasedatabase.dart';
import 'package:pasabuy/views/components/post-card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> posts = [];
  @override
  void initState() {
    super.initState();
    FirebaseDatabase db = FirebaseDatabaseInstance().database;
    DatabaseReference ref = db.ref('posts');
    ref.onValue.listen((data) {
      if (data.snapshot.exists) {
        for (var content in data.snapshot.children) {
          List<String> imageUrls = [];
          String postId = content.key.toString();
          String uid = content.child('uid').value.toString();
          String body = content.child('content').value.toString();
          int createdAt = int.parse(content.child('created_at').value.toString());
          if (content.child('image_urls').value != null) {
            imageUrls = List<String>.from(content.child('image_urls').value as List);
          }
          setState(() {
            posts.add(Post(postId, uid, body, imageUrls, createdAt));
          });
        }
      }
      setState(() {
        posts = posts.reversed.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed('new-post');
        },
        tooltip: "Add post",
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostCard(postData: posts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
