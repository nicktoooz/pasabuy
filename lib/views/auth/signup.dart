import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasabuy/models/user.dart';
import 'package:pasabuy/models/userdata.dart';
import 'package:pasabuy/sanitiser/userdata.dart';
import 'package:pasabuy/views/components/customtextfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = '';
  String password = '';
  String verifyPassword = '';
  String name = '';
  String phone = '';
  String age = '0';
  bool isAccepted = false;
  bool isAcceptedUI = true;
  bool isObscured = true;
  bool isObscuredVerify = true;

  Map<String, String> errors = {};

  @override
  void dispose() {
    errors.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: clampDouble(screenWidth / 10, 0, 40),
                      ),
                    ),
                  ),
                  CustomTextField(
                    prefixIcon: Icons.person,
                    hintText: "Full name",
                    errorText: errors['name-error'],
                    onChanged: (value) {
                      name = value;
                      setState(() {
                        errors.remove('name-error');
                      });
                    },
                  ),
                  CustomTextField(
                    prefixIcon: Icons.cake,
                    hintText: "Age",
                    errorText: errors['age-error'],
                    onChanged: (value) {
                      age = value;
                      setState(() {
                        errors.remove('age-error');
                      });
                    },
                  ),
                  CustomTextField(
                    prefixIcon: Icons.phone,
                    hintText: "Phone number",
                    errorText: errors['phone-error'],
                    onChanged: (value) {
                      phone = value;
                      setState(() {
                        errors.remove('phone-error');
                      });
                    },
                  ),
                  CustomTextField(
                    prefixIcon: Icons.email,
                    hintText: "Email Address",
                    errorText: errors['email-error'],
                    onChanged: (value) {
                      email = value;
                      setState(() {
                        errors.remove('email-error');
                      });
                    },
                  ),
                  CustomTextField(
                    prefixIcon: Icons.lock,
                    hintText: "Password",
                    obscureText: isObscured,
                    suffixIcon: isObscured ? Icons.visibility_off : Icons.visibility,
                    onSuffixPressed: () {
                      setState(() {
                        isObscured = !isObscured;
                      });
                    },
                    errorText: errors['password-error'],
                    onChanged: (value) {
                      password = value;
                      setState(() {
                        errors.remove('password-error');
                      });
                    },
                  ),
                  CustomTextField(
                    prefixIcon: Icons.lock,
                    hintText: "Verify Password",
                    obscureText: isObscuredVerify,
                    suffixIcon: isObscuredVerify ? Icons.visibility_off : Icons.visibility,
                    onSuffixPressed: () {
                      setState(() {
                        isObscuredVerify = !isObscuredVerify;
                      });
                    },
                    errorText: errors['confirm-password-error'],
                    onChanged: (value) {
                      verifyPassword = value;
                      setState(() {
                        errors.remove('confirm-password-error');
                      });
                    },
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Checkbox(
                          value: isAccepted,
                          onChanged: (value) {
                            setState(() {
                              isAccepted = value!;
                            });
                          }),
                      const Text('I accept the'),
                      TextButton(onPressed: () {}, child: const Text('Terms and Conditions'))
                    ],
                  ),
                  if (!isAcceptedUI && !isAccepted)
                    const Text(
                      "You need to agree to create an account",
                      style: TextStyle(color: Colors.red),
                    ),
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
                      onPressed: () async {
                        try {
                          UserData data = UserData(
                              name: name,
                              age: int.parse(age),
                              phone: phone,
                              email: email,
                              password: password,
                              confirmPassword: verifyPassword);

                          setState(() {
                            errors = UserDataSanitise.sanitiseSignUp(data);
                            isAcceptedUI = isAccepted;
                          });
                          if (errors.isNotEmpty) return;
                          User.signUp(data).then((res) {
                            context.go('/');
                          });
                        } catch (e) {
                          if (e.toString().contains('email-already-in-use')) {
                            setState(() {
                              errors['email-error'] = 'Email is already in use';
                            });
                          }
                        }
                      },
                      child: const Text("Sign Up"),
                    ),
                  ),
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
                        context.goNamed('sign-in');
                      },
                      child: const Text("Sign In"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
