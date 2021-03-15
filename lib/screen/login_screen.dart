import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/enums/login_status.dart';
import 'package:kuma_flutter_app/model/api/social_user.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('로그인'),
        ),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            switch (state.status) {
              case LoginStatus.LoginSuccess :
                showToast(msg: LoginStatus.LoginSuccess.msg);
                Navigator.pop(context);
                break;
              case LoginStatus.WrongPassword :
                showToast(msg: LoginStatus.WrongPassword.msg);
                break;
              case LoginStatus.NeedRegister :
                showToast(msg: LoginStatus.NeedRegister.msg);
                Navigator.pushNamed(
                    context, Routes.REGISTER, arguments: state.userData);
                break;
              case LoginStatus.Failure :
                showToast(msg: LoginStatus.Failure.msg);
                break;
              default:
                break;
            }
          },
          builder: (context, state) {
            if (state.status == LoginStatus.Loading) {
              return LoadingIndicator(isVisible: true,);
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    color: Colors.yellow,
                    child: TextButton(onPressed: () =>
                        BlocProvider.of<LoginBloc>(context).add(
                            Login(type: SocialType.KAKAO, context: context)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/kakao_talk_logo.png", width: 30,
                            height: 30,
                            alignment: Alignment.center,),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(width: 100,
                                child: CustomText(
                                  text: "카카오톡 로그인", fontSize: 15,)),
                          )
                        ],
                      ),),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    color: Colors.blue,
                    child: TextButton(onPressed: () =>
                        BlocProvider.of<LoginBloc>(context).add(
                            Login(type: SocialType.GOOGLE, context: context)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                              "assets/images/google_icon.png", width: 30,
                              height: 30,
                              alignment: Alignment.center),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(width: 100,
                                child: CustomText(
                                  text: "구글 로그인", fontSize: 15,)),
                          )
                        ],
                      ),),
                  )
                ],
              );
            }
          },
        )
    );
  }
}
