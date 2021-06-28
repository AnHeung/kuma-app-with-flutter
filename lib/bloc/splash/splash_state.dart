part of 'splash_bloc.dart';
enum SplashStatus {Initial , Loading, Failure , Success , NetworkError}

class SplashState extends Equatable{

  final SplashStatus status;
  final bool isAppFirstLaunch;
  final String msg;

  @override
  List<Object> get props =>[status, isAppFirstLaunch ,msg];

 const SplashState({this.status = SplashStatus.Initial , this.isAppFirstLaunch = false ,this.msg = ""});

}
