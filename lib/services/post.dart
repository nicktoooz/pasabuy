import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pasabuy/models/post.dart';

class PostController extends StateNotifier<List<Post>> {
  PostController() : super([]);

  Future<List<Post>> getNewPosts(int timestamp) async {
    List<Post> newPosts = [];

    FirebaseFirestore db = FirebaseFirestore.instance;

    try {
      QuerySnapshot snapshot = await db
          .collection('Posts')
          .orderBy('created_at', descending: true)
          .where('created_at', isLessThan: timestamp)
          .limit(2)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          var data = doc.data() as Map<String, dynamic>;
          List<String> imageUrls = [];

          String postId = doc.id;
          String uid = data['uid'] ?? '';
          String body = data['content'] ?? '';
          String address = data['address'] ?? '';
          int createdAt = data['created_at'] ?? 0;

          if (data['image_urls'] != null) {
            imageUrls = List<String>.from(data['image_urls']);
          }
          newPosts.add(Post(postId, uid, body, address, imageUrls, createdAt));
        }
      }
    } finally {}

    return newPosts;
  }

  Future<List<Post>> getPosts() async {
    List<Post> newPosts = [];
    FirebaseFirestore db = FirebaseFirestore.instance;

    QuerySnapshot snapshot =
        await db.collection('Posts').orderBy('created_at', descending: true).limit(3).get();

    if (snapshot.docs.isNotEmpty) {
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        List<String> imageUrls = [];

        String postId = doc.id;
        String uid = data['uid'] ?? '';
        String body = data['content'] ?? '';
        String address = data['address'] ?? '';
        int createdAt = data['created_at'] ?? 0;
        if (data['image_urls'] != null) {
          imageUrls = List<String>.from(data['image_urls']);
        }
        newPosts.add(Post(postId, uid, body, address, imageUrls, createdAt));
      }
    }
    return newPosts;
  }
}

final postControllerProvider =
    StateNotifierProvider<PostController, List<Post>>((ref) => PostController());
