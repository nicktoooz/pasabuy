import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasabuy/models/user.dart';
import 'package:pasabuy/models/userdata.dart';
import 'package:pasabuy/sanitiser/userdata.dart';
import 'package:pasabuy/views/auth/signup.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Map<String, String> errors = {};
  String email = '';
  String password = '';
  bool isObscured = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    errors.clear();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Text(
                  "Sign-In",
                  style: TextStyle(
                    fontSize: clampDouble(screenWidth / 10, 0, 40),
                  ),
                ),
              ),
              CustomTextField(
                  context: context,
                  prefixIcon: Icons.mail,
                  hintText: 'Email Address',
                  errorText: errors['email-error'],
                  onChanged: (value) {
                    email = value;
                    setState(() {
                      errors.remove('email-error');
                    });
                  }),
              CustomTextField(
                  context: context,
                  prefixIcon: Icons.lock,
                  hintText: 'Password',
                  obscureText: isObscured,
                  errorText: errors['password-error'],
                  suffixIcon: isObscured ? Icons.visibility_off : Icons.visibility,
                  onSuffixPressed: () {
                    setState(() {
                      isObscured = !isObscured;
                    });
                  },
                  onChanged: (value) {
                    password = value;
                    setState(() {
                      errors.remove('password-error');
                    });
                  }),
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 16),
                  height: 50,
                  child: FilledButton(
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          errors = UserDataSanitise.sanitiseSignIn(
                              UserData(email: email, password: password));
                        });
                        if (errors.isNotEmpty) return;
                        User.signIn(email, password).then((user) {
                          context.go('/');
                        }).catchError((error) {});
                      },
                      child: const Text("Sign In"))),
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 16),
                  height: 50,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        context.goNamed('sign-up');
                      },
                      child: const Text("Sign Up")))
            ],
          ),
        ),
      )),
    );
  }
}
