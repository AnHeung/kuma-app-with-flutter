import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/enums/image_type.dart';


onLoad(BuildContext context){
  showGeneralDialog(
    context: context,
    barrierColor: Colors.black12.withOpacity(0.6), // background color
    barrierDismissible: false, // should dialog be dismissed when tapped outside
    barrierLabel: "Dialog", // label for barrier
    transitionDuration: Duration(milliseconds: 400), // how long it takes to popup dialog after button click
    pageBuilder: (_, __, ___) { // your widget implementation
      return SizedBox.expand( // makes widget fullscreen
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 9,
              child: SizedBox.expand(child: FlutterLogo()),
            ),
            Expanded(
              flex: 1,
              child: SizedBox.expand(
                child: RaisedButton(
                  color: Colors.blue[900],
                  child: Text(
                    "Dismiss",
                    style: TextStyle(fontSize: 40),
                  ),
                  textColor: Colors.white,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}


showBaseDialog({String title , String content, String confirmTxt , String cancelTxt,  BuildContext context ,VoidCallback confirmFunction, VoidCallback cancelFunction}){
  showDialog(
    context: context,
    barrierColor: Colors.black12.withOpacity(0.6), // background color
    barrierDismissible: false, // should dialog be dismissed when tapped outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title ?? '알림'),
        content: Text(content ?? '내용'),
        actions: <Widget>[
          FlatButton(
            child: Text(confirmTxt ?? '확인'),
            onPressed: confirmFunction,
          ),
          FlatButton(
            child: Text(cancelTxt ?? '취소'),
            onPressed: cancelFunction,
          ),
        ],
      );
    },
  );
}

showOneBtnDialog({String title , String content, String confirmTxt ,  BuildContext context ,VoidCallback confirmFunction}){
  showDialog(
    context: context,
    barrierColor: Colors.black12.withOpacity(0.6), // background color
    barrierDismissible: false, // should dialog be dismissed when tapped outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title ?? '알림'),
        content: Text(content ?? '내용'),
        actions: <Widget>[
          FlatButton(
            child: Text(confirmTxt ?? '확인'),
            onPressed: confirmFunction,
          ),
        ],
      );
    },
  );
}

checkImageType(String res){
  if(res.isEmpty){
    return ImageType.NO_IMAGE;
  }else if(res.startsWith("/data")){
    return ImageType.FILE;
  }else{
    return ImageType.NETWORK;
  }
}
