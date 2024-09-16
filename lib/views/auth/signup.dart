import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasabuy/models/user.dart';
import 'package:pasabuy/models/userdata.dart';
import 'package:pasabuy/sanitiser/userdata.dart';

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
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
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

                          User user = await User.signUp(data);
                          String firstName = await User.name;
                          print("Logged in as ${firstName}");
                          context.go('/');
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
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent, width: 2),
                          borderRadius: BorderRadius.circular(8)),
                      margin: const EdgeInsets.only(top: 16),
                      height: 50,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.blueAccent,
                          ),
                          onPressed: () {
                            context.goNamed('sign-in');
                          },
                          child: const Text("Sign In")))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget CustomTextField({
  required IconData prefixIcon,
  IconData? suffixIcon,
  required String hintText,
  String? errorText,
  bool obscureText = false,
  required ValueChanged<String> onChanged,
  VoidCallback? onSuffixPressed, // Optional suffix icon press handler
}) {
  final hasError = errorText != null && errorText.isNotEmpty;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: hasError ? const Color(0xFFEF9A9A) : Colors.blue.shade100.withAlpha(80),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Icon(
              prefixIcon,
              size: 25,
              color: hasError ? const Color(0xFFEF9A9A) : Colors.grey,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: hasError ? const Color(0xFFEF9A9A) : Colors.grey,
              width: 2,
              height: 20,
            ),
            Expanded(
              child: TextFormField(
                obscureText: obscureText,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            if (suffixIcon != null)
              IconButton(
                onPressed: onSuffixPressed,
                icon: Icon(
                  suffixIcon,
                  size: 25,
                  color: hasError ? const Color(0xFFEF9A9A) : Colors.grey,
                ),
              ),
          ],
        ),
      ),
      if (hasError)
        Padding(
          padding: const EdgeInsets.only(bottom: 1.5),
          child: Row(
            children: [
              const Icon(Icons.error, size: 14, color: Colors.red),
              const SizedBox(width: 5),
              Text(errorText, style: const TextStyle(color: Colors.red)),
            ],
          ),
        )
      else
        const SizedBox(height: 10),
    ],
  );
}
