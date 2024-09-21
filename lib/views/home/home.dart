import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pasabuy/models/post.dart';
import 'package:pasabuy/services/post.dart';
import 'package:pasabuy/utils/dialog-builder.dart';
import 'package:pasabuy/views/components/post-card.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  ScrollController scrollController = ScrollController();
  List<Post> posts = [];
  int timestamp = 0;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    initialPostLoad();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        loadMorePosts();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future refresh() async {
    initialPostLoad();
  }

  Future loadMorePosts() async {
    int ts = posts.last.createdAt;
    final newPost = await ref.read(postControllerProvider.notifier).getNewPosts(ts);
    setState(() {
      if (newPost.isEmpty) {
        hasMore = false;
      }
      posts.addAll(newPost);
    });
  }

  void initialPostLoad() async {
    final newPost = await ref.read(postControllerProvider.notifier).getPosts();
    var p = newPost;
    setState(() {
      posts = p;
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
            child: Center(
              child: posts.isEmpty
                  ? const CircularProgressIndicator()
                  : RefreshIndicator(
                      onRefresh: refresh,
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: posts.length + 1,
                        itemBuilder: (context, index) {
                          if (index < posts.length) {
                            return PostCard(postData: posts[index], onImageTap: () {});
                          } else {
                            if (hasMore) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }
                          return null;
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
