import 'dart:async';
import 'package:flutter/material.dart';

Future<void> buildDialog({
  required BuildContext context,
  required bool canDismiss,
  required Widget child,
  required Function(BuildContext) onLoad,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: canDismiss,
    builder: (BuildContext dialogContext) {
      onLoad(dialogContext);
      return Dialog(
        child: child,
      );
    },
  );
}
