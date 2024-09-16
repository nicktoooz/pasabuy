import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed('messages');
        },
        child: const Badge(
          label: Text('2'),
          child: Icon(Icons.message),
        ),
      ),
      body: const Column(
        children: [Text("Home")],
      ),
    );
  }
}
