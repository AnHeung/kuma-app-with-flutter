import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/splash/splash_bloc.dart';
import 'package:kuma_flutter_app/enums/base_bloc_state_status.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/screen/splash_animation_screen.dart';
import 'package:kuma_flutter_app/util/common.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: createMaterialColor(kWhite),
        body: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            bool isLoading = state.status ==  BaseBlocStateStatus.Loading;

            if (state.status ==  BaseBlocStateStatus.Success) {
              WidgetsBinding.instance.addPostFrameCallback((_) async{
                if (state.isAppFirstLaunch) {
                  await saveAppFirstLaunch(isAppFirst: false);
                  Navigator.pushNamedAndRemoveUntil(context, Routes.FIRST_LAUNCH, (route) => false);
                } else {
                  Navigator.pop(context);
                }
              });
            } else if (state.status == BaseBlocStateStatus.Failure) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showToast(msg: "에러발생 다시 시도해주세요");
                SystemNavigator.pop();
              });
            }
            return SplashAnimationScreen(isLoading :isLoading);
          },
        ));
  }
}
