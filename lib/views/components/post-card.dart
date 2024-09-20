import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pasabuy/models/post.dart';
import 'package:relative_time/relative_time.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PostCard extends StatefulWidget {
  final Post postData;

  const PostCard({super.key, required this.postData});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  String name = '';

  @override
  void initState() {
    super.initState();
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference ref = db.collection('Users').doc(widget.postData.userId);
    if (mounted) {
      ref.get().then((data) {
        if (mounted) {
          setState(() {
            name = data['name'].toString();
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer.zone(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  color: Colors.blue.withAlpha(20),
                  padding: const EdgeInsets.all(4),
                  child: CachedNetworkImage(
                    alignment: Alignment.center,
                    imageUrl:
                        'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
                    height: 40,
                    width: 40,
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 17.sp),
                    ),
                    Text(RelativeTime(context).format(
                      DateTime.fromMillisecondsSinceEpoch(widget.postData.createdAt),
                    )),
                    Text(widget.postData.address),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                widget.postData.content,
                style: TextStyle(fontSize: 17.sp),
              ),
            ),
            widget.postData.imageUrls.isNotEmpty
                ? SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        imageUrl: widget.postData.imageUrls[0],
                      ),
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey.shade300,
                    margin: const EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 20),
                  )
          ],
        ),
      ),
    );
  }
}
