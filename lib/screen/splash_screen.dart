import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/splash/splash_bloc.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: createMaterialColor(kBlue),
        body: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            bool isLoading = state is SplashLoadInProgress;

            if (state is SplashLoadSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (state.isAppFirstLaunch) {
                  Navigator.pushNamedAndRemoveUntil(context, Routes.FIRST_LAUNCH, (route) => false);
                } else {
                  Navigator.pop(context);
                }
              });
            } else if (state is SplashLoadFailure) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showToast(msg: "에러발생 다시 시도해주세요");
                SystemNavigator.pop();
              });
            }
            return LoadingIndicator(
              isVisible: isLoading,
              color: Colors.white,
            );
          },
        ));
  }
}
