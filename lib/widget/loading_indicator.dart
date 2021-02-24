import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/search/search_bloc.dart';

class LoadingIndicator extends StatelessWidget {

  final bool isVisible;
  final Color color;

  LoadingIndicator({bool isVisible , Color color}): this.color = color ?? Colors.blue , this.isVisible = isVisible ?? false;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Visibility(
        visible: isVisible,
        child: Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          child: CircularProgressIndicator(backgroundColor: color,),
        ),
      ),
    );
  }
}
