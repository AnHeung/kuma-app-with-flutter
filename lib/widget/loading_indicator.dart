import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {

  final bool isVisible;
  final Color color;

  LoadingIndicator({bool isVisible , Color color}): this.color = color ?? Colors.white , this.isVisible = isVisible ?? false;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Visibility(
        visible: isVisible,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            alignment: Alignment.center,
            child: const CupertinoActivityIndicator(radius: 20,),
          ),
        ),
      ),
    );
  }
}
