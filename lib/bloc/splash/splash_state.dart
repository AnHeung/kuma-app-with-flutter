part of 'splash_bloc.dart';

@immutable
abstract class SplashState extends Equatable{
  @override
  List<Object> get props =>[];

 const SplashState();

}

class SplashInit extends SplashState {}

class SplashLoadInProgress extends SplashState {}


class SplashLoadSuccess extends SplashState {

  final bool isAppFirstLaunch;

  const SplashLoadSuccess({this.isAppFirstLaunch});
}

class SplashLoadFailure extends SplashState {}

class Splash extends SplashState {}
