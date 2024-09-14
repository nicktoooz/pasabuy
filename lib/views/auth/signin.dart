import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasabuy/main.dart';
import 'package:pasabuy/models/user.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String _email = '';
    String _password = '';

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextFormField(
              onChanged: (val) => _email = val,
              decoration: InputDecoration(hintText: "Email Address"),
            ),
            TextFormField(
              onChanged: (val) => _password = val,
              decoration: InputDecoration(hintText: "Password"),
            ),
            ElevatedButton(
                onPressed: () {
                  User.signIn(_email, _password).then((user) {
                    context.go('/');
                  }).catchError((error) {
                    print(error);
                  });
                },
                child: const Text("Sign In")),
            ElevatedButton(
                onPressed: () {
                  context.go('/auth/sign-up');
                },
                child: Text("Sign Up"))
          ],
        ),
      ),
    );
  }
}
