part of 'login_widget.dart';

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
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CustomText(
                  text: kLoginDialogTitle,
                  fontFamily: doHyunFont,
                  fontSize: 20.0,
                )),
            DefaultTextField(
              title: kLoginDialogIdTitle,
              textSize: 13,
              controller: idController,
              validator: (value) => validateEmail(value),
            ),
            DefaultTextField(
              title: kLoginDialogPwTitle,
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
                              userId: id,
                              uniqueId: pw,
                              loginType: LoginType.EMAIL)));
                      Navigator.pop(context);
                    }
                  },
                  child: CustomText(
                    text: kLoginDialogTitle,
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
