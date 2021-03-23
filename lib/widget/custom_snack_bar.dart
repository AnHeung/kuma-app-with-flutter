import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({@required String msg, VoidCallback onUndo})
      : super(
            content: Text(msg, maxLines: 1),
            duration: Duration(seconds: 1),
            action: onUndo!= null ? SnackBarAction(
              label: '되돌리기',
              onPressed: onUndo,
            ): null);
}
