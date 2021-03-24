import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/enums/login_status.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/login_dialog.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar:AppBar(
          title: Text('로그인'),
        ),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            switch (state.status) {
              case LoginStatus.LoginSuccess:
                showToast(msg: LoginStatus.LoginSuccess.msg);
                Navigator.pop(context);
                break;
              case LoginStatus.WrongPassword:
                showToast(msg: LoginStatus.WrongPassword.msg);
                break;
              case LoginStatus.NeedRegister:
                showToast(msg: LoginStatus.NeedRegister.msg);
                Navigator.pushNamed(context, Routes.REGISTER,
                    arguments: state.userData);
                break;
              case LoginStatus.Failure:
                showToast(msg: LoginStatus.Failure.msg);
                break;
              case LoginStatus.CheckEmail:
                showToast(msg: LoginStatus.CheckEmail.msg);
                break;
              case LoginStatus.NeedLoginScreen:
                _showLoginDialog(context:context);
                break;
              default:
                break;
            }
          },
          builder: (context, state) {
            if (state.status == LoginStatus.Loading) {
              return LoadingIndicator(
                isVisible: true,
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLoginButton(bgColor: Colors.yellow ,
                      buttonText: "카카오 로그인",
                      imgRes: LoginType.KAKAO.iconRes, onPress: () => BlocProvider.of<LoginBloc>(context).add(Login(type: LoginType.KAKAO, context: context))),
                  _buildLoginButton(bgColor: kBlue ,
                      buttonText: "구글 로그인" ,
                      imgRes: LoginType.GOOGLE.iconRes ,
                      onPress: () => BlocProvider.of<LoginBloc>(context).add(Login(type: LoginType.GOOGLE, context: context))),
                  _buildLoginButton(bgColor: Colors.grey.withOpacity(0.5) ,
                      buttonText: "이메일 로그인" ,
                      imgRes: LoginType.EMAIL.iconRes ,
                      onPress: () => BlocProvider.of<LoginBloc>(context).add(Login(type: LoginType.EMAIL, context: context))),
                ],
              );
            }
          },
        ));
  }

  _buildLoginButton({ Color bgColor, VoidCallback onPress , String imgRes , String buttonText}){
   return Container(
     decoration: BoxDecoration(
         color: bgColor,
         borderRadius: BorderRadius.all(Radius.circular(10))),
     height: 50,
     margin: EdgeInsets.only(left: 20, right: 20, top: 20),
     child: TextButton(
       onPressed: onPress,
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Container(
             width: 30,
             height: 30,
             child: ImageItem(
               type: ImageShapeType.FLAT,
               imgRes: imgRes,
             ),
           ),
           Padding(
             padding: const EdgeInsets.only(left: 8.0),
             child: Container(
                 width: 100,
                 child: CustomText(
                   fontFamily: doHyunFont,
                   text: buttonText,
                   fontSize: kLoginFontSize,
                 )),
           )
         ],
       ),
     ),
   );
  }

  _showLoginDialog({BuildContext context}){
    showDialog(context: context, builder: (_){
      return LoginDialog(bloc:  BlocProvider.of<LoginBloc>(context),);
    });
  }
}
