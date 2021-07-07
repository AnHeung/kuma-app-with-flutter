import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kuma_flutter_app/app_constants.dart';

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
      title: const Text(kErrorTitle),
      content: Text("$kErrorTitle ${widget.terminateMsg}"),
      actions: <Widget>[
        TextButton(
          child: const Text(kErrorTerminateTitle),
          onPressed: () =>  SystemNavigator.pop(),
        ),
      ],
    );
  }
}
