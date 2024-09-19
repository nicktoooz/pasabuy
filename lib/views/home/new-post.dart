import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:pasabuy/models/user.dart';
import 'package:pasabuy/utils/firebasedatabase.dart';
import 'package:sizer/sizer.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  String content = '';
  final controller = MultiImagePickerController(
      maxImages: 5,
      picker: (allowMultiple) async {
        return await pickImagesUsingImagePicker(allowMultiple);
      });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create post'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              minLines: 10,
              maxLines: 12,
              onChanged: (val) {
                content = val;
              },
              decoration: const InputDecoration(hintText: 'Type here'),
            ),
            Expanded(
              child: MultiImagePickerView(
                controller: controller,
                padding: const EdgeInsets.all(10),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              height: 50,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  var images = controller.images;
                  FirebaseDatabase db = FirebaseDatabaseInstance().database;
                  int createdAt = DateTime.now().millisecondsSinceEpoch;
                  List<String> imageUrls = [];
                  DatabaseReference ref = db.ref('posts/${User().uid}');
                  String key = ref.push().key.toString();
                  imageUrls = await uploadImages(images, key);
                  ref.child(key).set({
                    'created_at': createdAt,
                    'content': content,
                    'image_urls': imageUrls,
                  });
                },
                child: Text(
                  "Post",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<String>> uploadImages(Iterable<ImageFile> images, String key) async {
  final FirebaseStorage storage = FirebaseStorage.instance;
  List<String> imageUrls = [];

  for (var image in images) {
    File file = File(image.path!);
    try {
      Reference ref = storage
          .ref()
          .child('post_images/${User().uid}/$key/${DateTime.now().millisecondsSinceEpoch}.jpg');

      UploadTask uploadTask = ref.putFile(file);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress = snapshot.bytesTransferred / snapshot.totalBytes;
        print('Upload progress: ${progress * 100} %');
      });

      await uploadTask;

      String downloadUrl = await ref.getDownloadURL();
      imageUrls.add(downloadUrl);
      print('Uploaded image URL: $downloadUrl');
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  return imageUrls;
}

Future<List<ImageFile>> pickImagesUsingImagePicker(bool allowMultiple) async {
  final picker = ImagePicker();
  final List<XFile> xFiles;
  if (allowMultiple) {
    xFiles = await picker.pickMultiImage(maxWidth: 1080, maxHeight: 1080);
  } else {
    xFiles = [];
    final xFile =
        await picker.pickImage(source: ImageSource.gallery, maxHeight: 1080, maxWidth: 1080);
    if (xFile != null) {
      xFiles.add(xFile);
    }
  }
  if (xFiles.isNotEmpty) {
    return xFiles.map<ImageFile>((e) => convertXFileToImageFile(e)).toList();
  }
  return [];
}
