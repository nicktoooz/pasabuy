import 'package:flutter/material.dart';
import 'package:pasabuy/models/user.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name = '';
  @override
  void initState() {
    super.initState();
    _initialiseData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Badge(
          label: Text('2'),
          child: Icon(Icons.message),
        ),
      ),
      body: Column(
        children: [
          Text(
            "Hello $name!",
            style: const TextStyle(fontSize: 30),
          ),
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
