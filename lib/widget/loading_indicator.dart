import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';

enum LoadingIndicatorType { IPHONE ,  CIRCLE}

class LoadingIndicator extends StatelessWidget {

  final bool isVisible;
  final Color color;
  final LoadingIndicatorType type;

  const LoadingIndicator({bool isVisible , Color color, LoadingIndicatorType type}): this.color = color ?? kWhite, this.isVisible = isVisible ?? false , this.type = type ?? LoadingIndicatorType.CIRCLE;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Visibility(
        visible: isVisible,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            alignment: Alignment.center,
            child: _configIndicator(color: color , type: type),
          ),
        ),
      ),
    );
  }

  _configIndicator ({LoadingIndicatorType type , Color color}){
    switch(type){
      case LoadingIndicatorType.IPHONE :
         return const CupertinoActivityIndicator(radius: 20,);
      case LoadingIndicatorType.CIRCLE :
        return CircularProgressIndicator(backgroundColor: color, valueColor: const AlwaysStoppedAnimation<Color>(kDisabled),);
    }
  }
}
