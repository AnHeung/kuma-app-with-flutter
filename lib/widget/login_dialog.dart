import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/model/api/social_user.dart';
import 'package:kuma_flutter_app/util/vaildate_util.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/default_text_field.dart';

class LoginDialog extends StatefulWidget {
  final LoginBloc bloc;

  const LoginDialog({this.bloc});

  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final pwController = TextEditingController();
  String id;
  String pw;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: _loginContainer(context: context),
    );
  }

  Widget _loginContainer({BuildContext context}) {
    return Container(
      height: 450,
      padding: const EdgeInsets.all(20),
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: CustomText(
                  text: "로그인/회원가입",
                  fontFamily: doHyunFont,
                  fontSize: 20.0,
                )),
            DefaultTextField(
              title: "이메일",
              textSize: 13,
              controller: idController,
              validator: (value) => validateEmail(value),
            ),
            DefaultTextField(
              title: "비밀번호",
              textSize: 13,
              isObscureText: true,
              controller: pwController,
              validator: (value) => validateUserPw(value),
            ),
            Container(
                margin: const EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width,
                color: kBlue,
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      String id = idController.text.trim();
                      String pw = pwController.text.trim();
                      widget.bloc.add(DirectLogin(
                          userData: LoginUserData(
                              userName: id,
                              email: id,
                              uniqueId: pw,
                              loginType: LoginType.EMAIL)));
                      Navigator.pop(context);
                    }
                  },
                  child: CustomText(
                    text: '로그인/회원가입',
                    fontSize: 13.0,
                    fontFamily: doHyunFont,
                    fontColor: kWhite,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
