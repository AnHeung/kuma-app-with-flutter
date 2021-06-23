part of 'splash_bloc.dart';

class SplashState extends Equatable{

  final BaseBlocStateStatus status;
  final bool isAppFirstLaunch;

  @override
  List<Object> get props =>[status];

 const SplashState({this.status = BaseBlocStateStatus.Initial , this.isAppFirstLaunch = false});

}
