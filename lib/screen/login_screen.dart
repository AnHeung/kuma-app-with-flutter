part of 'screen.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar:AppBar(
          title: const Text(kLoginTitle),
        ),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            switch (state.status) {
              case LoginStatus.LoginSuccess:
                showToast(msg: LoginStatus.LoginSuccess.msg);
                BlocProvider.of<NotificationBloc>(context).add(NotificationLoad());
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
                showDialog(context: context, builder: (_){
                  return LoginDialog(bloc:  BlocProvider.of<LoginBloc>(context),);
                });
                break;
              default:
                break;
            }
          },
          builder: (context, state) {
            if (state.status == LoginStatus.Loading) {
              return const LoadingIndicator(
                isVisible: true,
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginButton(bgColor: Colors.yellow ,
                      buttonText: kLoginKakao,
                      imgRes: LoginType.KAKAO.iconRes, onPress: () => BlocProvider.of<LoginBloc>(context).add(Login(type: LoginType.KAKAO, context: context))),
                  LoginButton(bgColor: kBlue ,
                      buttonText: kLoginGoogle ,
                      imgRes: LoginType.GOOGLE.iconRes ,
                      onPress: () => BlocProvider.of<LoginBloc>(context).add(Login(type: LoginType.GOOGLE, context: context))),
                  LoginButton(bgColor: Colors.grey.withOpacity(0.5) ,
                      buttonText: kLoginEmail ,
                      imgRes: LoginType.EMAIL.iconRes ,
                      onPress: () => BlocProvider.of<LoginBloc>(context).add(Login(type: LoginType.EMAIL, context: context))),
                ],
              );
            }
          },
        ));
  }


}
