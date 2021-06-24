import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/widget/animation/animation_widget.dart';


class AnimationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: AnimationScrollView(),
    );
  }
}

