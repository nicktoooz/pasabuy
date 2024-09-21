import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pasabuy/models/post.dart';
import 'package:pasabuy/models/user.dart';
import 'package:pasabuy/utils/dialog-builder.dart';
import 'package:relative_time/relative_time.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PostCard extends StatefulWidget {
  final Post postData;
  final void Function() onImageTap;

  const PostCard({super.key, required this.postData, required this.onImageTap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  String name = '';
  String input = '';

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
    return Container(
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
              ? GestureDetector(
                  onTap: widget.onImageTap,
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxHeight: 400),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: widget.postData.imageUrls.length == 1
                          ? GestureDetector(
                              child: CachedNetworkImage(
                                imageUrl: widget.postData.imageUrls[0],
                                width: double.infinity,
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.center,
                              ),
                              onTap: () {
                                buildDialog(
                                    context: context,
                                    canDismiss: true,
                                    child:
                                        CachedNetworkImage(imageUrl: widget.postData.imageUrls[0]),
                                    onLoad: (ctx) {});
                              },
                            )
                          : widget.postData.imageUrls.length == 2
                              ? Flex(
                                  direction: Axis.vertical,
                                  children: [
                                    Flexible(
                                        child: GestureDetector(
                                      child: CachedNetworkImage(
                                        imageUrl: widget.postData.imageUrls[0],
                                        width: double.infinity,
                                        fit: BoxFit.fitWidth,
                                        alignment: Alignment.center,
                                      ),
                                      onTap: () {
                                        buildDialog(
                                            context: context,
                                            canDismiss: true,
                                            child: CachedNetworkImage(
                                                imageUrl: widget.postData.imageUrls[0]),
                                            onLoad: (ctx) {});
                                      },
                                    )),
                                    Flexible(
                                        child: GestureDetector(
                                      child: CachedNetworkImage(
                                        imageUrl: widget.postData.imageUrls[1],
                                        width: double.infinity,
                                        fit: BoxFit.fitWidth,
                                        alignment: Alignment.center,
                                      ),
                                      onTap: () {
                                        buildDialog(
                                            context: context,
                                            canDismiss: true,
                                            child: CachedNetworkImage(
                                                imageUrl: widget.postData.imageUrls[1]),
                                            onLoad: (ctx) {});
                                      },
                                    )),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Expanded(
                                        child: GestureDetector(
                                      child: CachedNetworkImage(
                                        imageUrl: widget.postData.imageUrls[0],
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                                      onTap: () {
                                        buildDialog(
                                            context: context,
                                            canDismiss: true,
                                            child: CachedNetworkImage(
                                                imageUrl: widget.postData.imageUrls[0]),
                                            onLoad: (ctx) {});
                                      },
                                    )),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                              height: 120,
                                              child: GestureDetector(
                                                child: CachedNetworkImage(
                                                  imageUrl: widget.postData.imageUrls[1],
                                                  fit: BoxFit.cover,
                                                  alignment: Alignment.center,
                                                ),
                                                onTap: () {
                                                  buildDialog(
                                                      context: context,
                                                      canDismiss: true,
                                                      child: CachedNetworkImage(
                                                          imageUrl: widget.postData.imageUrls[1]),
                                                      onLoad: (ctx) {});
                                                },
                                              )),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            height: 120,
                                            child: Stack(
                                              children: [
                                                GestureDetector(
                                                  child: CachedNetworkImage(
                                                    imageUrl: widget.postData.imageUrls[2],
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    alignment: Alignment.center,
                                                  ),
                                                  onTap: () {
                                                    buildDialog(
                                                        context: context,
                                                        canDismiss: true,
                                                        child: CachedNetworkImage(
                                                            imageUrl: widget.postData.imageUrls[2]),
                                                        onLoad: (ctx) {});
                                                  },
                                                ),
                                                if (widget.postData.imageUrls.length > 3)
                                                  Positioned.fill(
                                                      child: GestureDetector(
                                                    onTap: () {
                                                      print('navigate');
                                                    },
                                                    child: Container(
                                                      color: const Color(0x8B333333),
                                                      child: Center(
                                                        child: Text(
                                                          "+${widget.postData.imageUrls.length - 3}",
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 17.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                    ),
                  ),
                )
              : Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey.shade300,
                  margin: const EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 20),
                ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (val) {
                      input = val;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Type message',
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    FirebaseDatabase database = FirebaseDatabase.instance;
                    DatabaseReference ref = database.ref('Messages');
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
