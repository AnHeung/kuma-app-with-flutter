part of 'screen.dart';

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
            return SplashAnimationPage(isLoading :isLoading);
          },
        ));
  }
}
