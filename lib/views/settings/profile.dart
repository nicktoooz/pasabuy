import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasabuy/models/user.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = '';
  @override
  void initState() {
    super.initState();
    _initialiseData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl:
                      'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
                  height: 60,
                  width: 60,
                ),
                const Spacer(),
                Text(
                  name,
                  style: TextStyle(fontSize: clampDouble(screenWidth, 0, 25)),
                )
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0.2,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero))),
              onPressed: () async {
                context.goNamed('settings');
              },
              child: const Text("Settings"),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0.2,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero))),
              onPressed: () async {
                await User.signOut().then((res) {
                  context.go('/sign-in');
                });
              },
              child: const Text("Sign Out"),
            ),
          )
        ],
      ),
    );
  }

  void _initialiseData() async {
    String name = await User.name;
    setState(() {
      this.name = name;
    });
  }
}
