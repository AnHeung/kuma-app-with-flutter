import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/splash/splash_bloc.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/screen/splash_animation_screen.dart';
import 'package:kuma_flutter_app/util/sharepref_util.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  AnimationController scaleAnimationController;
  Animation<double> _animation;


  @override
  void initState() {
    super.initState();
    scaleAnimationController = AnimationController(duration: const Duration(seconds: 2), vsync: this, value: 0.1);
    _animation = CurvedAnimation(parent: scaleAnimationController, curve: Curves.bounceInOut);
    scaleAnimationController?.forward();
  }

  @override
  void dispose() {
    super.dispose();
    scaleAnimationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: createMaterialColor(kWhite),
        body: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            bool isLoading = state.status ==  SplashStatus.loading;

            if (state.status ==  SplashStatus.success) {
              WidgetsBinding.instance.addPostFrameCallback((_) async{
                if (state.isAppFirstLaunch) {
                  await saveAppFirstLaunch(isAppFirst: false);
                  Navigator.pushNamedAndRemoveUntil(context, Routes.FIRST_LAUNCH, (route) => false);
                } else {
                  Navigator.pop(context);
                }
              });
            } else if (state.status == SplashStatus.failure) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showToast(msg: "에러발생 다시 시도해주세요");
                SystemNavigator.pop();
              });
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Container(
                   height: 200,
                    alignment: Alignment.center,
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
                ),
                Container(
                  height: 100,
                  child: LoadingIndicator(color: kWhite, isVisible: isLoading,),
                )
              ],
            );
          },
        ));
  }
}
