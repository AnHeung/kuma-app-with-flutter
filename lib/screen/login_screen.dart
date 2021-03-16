import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/enums/login_status.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';
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
                Navigator.pushNamed(context, Routes.REGISTER, arguments: state.userData);
                break;
              case LoginStatus.Failure :
                showToast(msg: LoginStatus.Failure.msg);
                break;
              case LoginStatus.CheckEmail :
                showToast(msg: LoginStatus.CheckEmail.msg);
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
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    height: 50,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextButton(onPressed: () =>
                        BlocProvider.of<LoginBloc>(context).add(
                            Login(type: SocialType.KAKAO, context: context)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            child: ImageItem(
                              type: ImageShapeType.FLAT,
                              imgRes: SocialType.KAKAO.iconRes,
                            ),
                          ),
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
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    height: 50,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    height: 50,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: TextButton(onPressed: () =>
                        BlocProvider.of<LoginBloc>(context).add(
                            Login(type: SocialType.GOOGLE, context: context)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.email_outlined, size: 30, color: Colors.white,) ,
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(width: 100,
                                child: CustomText(
                                  text: "이메일 로그인", fontSize: 15,)),
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
