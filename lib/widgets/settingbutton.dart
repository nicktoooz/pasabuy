import 'package:flutter/material.dart';

Widget SettingButton(Widget child) {
  return GestureDetector(
    onTap: () {},
    child: SizedBox(
      height: 70,
      child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: child,
          )),
    ),
  );
}
