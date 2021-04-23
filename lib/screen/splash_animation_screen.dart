import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';

class SplashAnimationScreen extends StatefulWidget {

  final isLoading;

  const SplashAnimationScreen({this.isLoading = false});

  _SplashAnimationState createState() => new _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimationScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _rotateAnimation;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(seconds: kSplashTime), vsync: this, value: 0.1);
    _rotateAnimation =  Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 2.0, end: 1.0)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 20.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.0, end: 0.0)
              .chain(CurveTween(curve: Curves.fastOutSlowIn)),
          weight: 20.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0)
              .chain(CurveTween(curve: Curves.fastOutSlowIn)),
          weight: 40.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.0, end: 0.0)
              .chain(CurveTween(curve: Curves.fastOutSlowIn)),
          weight: 5.0,
        ),
      ],
    ).animate(CurvedAnimation(parent: _animationController, curve: const Interval(0.1, 0.7)));

    _animationController?.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Stack(
        children: [
          Container(
              alignment: Alignment.center,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child){
                  return ScaleTransition(
                      scale: _scaleAnimation,
                      alignment: Alignment.center,
                      child: Material(  type: MaterialType.transparency, child: CustomText(text: "ANIMATION" ,fontFamily: doHyunFont, fontWeight: FontWeight.w700,   fontColor: kPurple,  fontSize: 50.0,)),
                  );
                },
              ),
          ),
          Container(
            alignment: Alignment.center,
            child: AnimatedBuilder(
                animation: _animationController,
                builder: (BuildContext context, Widget child) {
                  return Opacity(
                    opacity: _rotateAnimation.value,
                    child: RotationTransition(
                      turns: _rotateAnimation,
                      child: Material( type: MaterialType.transparency, child: CustomText(text: "N" ,fontFamily: doHyunFont, fontWeight: FontWeight.w700,   fontColor: kPurple,  fontSize: 50.0,)),
                    ),
                  );
                }),
          ),
          Align(alignment:Alignment.bottomCenter, child: Container(
            height: 100,
            child: LoadingIndicator(
              isVisible: widget.isLoading,
            ),
          ))
        ],
      ),
    );
  }
}
