import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/splash/splash_bloc.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Scaffold(
          backgroundColor: Colors.blue,
          body: Center(
              child: Text(
                '스플래시',
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
        ),
        BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            bool isLoading = state is SplashLoadInProgress;
            if (!isLoading) WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.pop(context));
            return LoadingIndicator(
              isVisible: isLoading,
              color: Colors.white,
            );
          },
        )
      ],
    );
  }
}
