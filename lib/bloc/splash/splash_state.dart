part of 'splash_bloc.dart';

enum SplashStatus {initial , loading , failure , success}

@immutable
class SplashState extends Equatable{

  final SplashStatus status;
  final bool isAppFirstLaunch;

  @override
  List<Object> get props =>[status];

 const SplashState({this.status = SplashStatus.initial , this.isAppFirstLaunch = false});

}
