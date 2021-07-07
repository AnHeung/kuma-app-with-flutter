import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({@required String msg, VoidCallback onUndo})
      : super(
            content: Text(msg, maxLines: 1),
            duration: const Duration(seconds: 1),
            action: onUndo!= null ? SnackBarAction(
              label: kUndoTitle,
              onPressed: onUndo,
            ): null);
}
