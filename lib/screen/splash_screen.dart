part of 'screen.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: createMaterialColor(kWhite),
        body: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            bool isLoading = state.status ==  SplashStatus.Loading;
            if (state.status ==  SplashStatus.Success) {
              WidgetsBinding.instance.addPostFrameCallback((_) async{
                if (state.isAppFirstLaunch) {
                  await saveAppFirstLaunch(isAppFirst: false);
                  Navigator.pushNamedAndRemoveUntil(context, Routes.FIRST_LAUNCH, (route) => false);
                } else {
                  Navigator.pushNamedAndRemoveUntil(context, Routes.HOME, (route) => false);
                }
              });
            } else if (state.status == SplashStatus.Failure || state.status == SplashStatus.NetworkError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showErrorDialog(context: context , errMsg: state.msg);
              });
            }
            return SplashAnimationPage(isLoading :isLoading);
          },
        ));
  }
}
