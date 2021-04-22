import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';

class SplashAnimationScreen extends StatefulWidget {
  _SplashAnimationState createState() => new _SplashAnimationState();
}

class _SplashAnimationState extends State<StatefulWidget>
    with SingleTickerProviderStateMixin {
  AnimationController scaleAnimationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    scaleAnimationController = AnimationController(duration: const Duration(milliseconds: 3000), vsync: this, value: 0.1);
    _animation = CurvedAnimation(parent: scaleAnimationController, curve: Curves.bounceIn);
    scaleAnimationController?.forward();
    // rotateAnimationController.repeat();
  }


  @override
  void dispose() {
    super.dispose();
    scaleAnimationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return  Container(
      color: kWhite,
      child: ScaleTransition(
          scale: _animation,
          alignment: Alignment.center,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Material(  type: MaterialType.transparency, child: CustomText(text: "ANIMATION" ,fontFamily: doHyunFont, fontWeight: FontWeight.w700,   fontColor: kPurple,  fontSize: 50.0,)),
              ]
          )
      ),
    );
  }
}