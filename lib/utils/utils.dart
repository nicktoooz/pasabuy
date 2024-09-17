import 'package:flutter/material.dart';

double getScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;

extension DurationExt on num {
  Duration get ms => Duration(milliseconds: toInt());
  Duration get s => Duration(seconds: toInt());
}
