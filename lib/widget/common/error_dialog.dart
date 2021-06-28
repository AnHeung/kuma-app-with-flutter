import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ErrorDialog extends StatefulWidget {
  final String terminateMsg;

  const ErrorDialog({this.terminateMsg});

  @override
  _ErrorDialogState createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("에러발생"),
      content: Text("에러발생 ${widget.terminateMsg}"),
      actions: <Widget>[
        TextButton(
          child: const Text('앱종료'),
          onPressed: () =>  SystemNavigator.pop(),
        ),
      ],
    );
  }
}
