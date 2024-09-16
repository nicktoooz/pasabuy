import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasabuy/models/user.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Profile'),
          ElevatedButton(
            onPressed: () {
              context.goNamed('settings');
            },
            child: const Text("Settings"),
          ),
          ElevatedButton(
            onPressed: () async {
              await User.signOut().then((res) {
                context.go('/sign-in');
              });
            },
            child: const Text("Sign Out"),
          ),
        ],
      ),
    );
  }
}
