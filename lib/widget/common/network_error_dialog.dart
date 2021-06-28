
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/network/network_bloc.dart';

class NetworkErrorDialog extends StatefulWidget {

  @override
  _NetworkErrorDialogState createState() => _NetworkErrorDialogState();
}

class _NetworkErrorDialogState extends State<NetworkErrorDialog> {

  int checkCount = 30;
  Timer checkTimer;

  @override
  void initState() {
    super.initState();
    checkTimer = checkTimer ?? Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if(checkCount < 1){
          BlocProvider.of<NetworkBloc>(context).add(NetworkTerminate());
          timer.cancel();
        }else{
          checkCount--;
        }
      });
    });
  }


  @override
  void dispose() {
    super.dispose();
    print('test dispose');
    checkTimer?.cancel();
    checkTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("네트워크 연결 끊김"),
      content: Text("네트워크 연결이 끊겼습니다. ${checkCount}초..."),
      actions: <Widget>[
        TextButton(
          child: const Text('앱종료'),
          onPressed: () =>  SystemNavigator.pop(),
        ),
      ],
    );
  }
}
