part of 'splash_bloc.dart';

@immutable
abstract class SplashState extends Equatable{
  @override
  List<Object> get props =>[];
}

class SplashLoadInProgress extends SplashState {}

class SplashLoadSuccess extends SplashState {

  bool isLogin;

  SplashLoadSuccess({this.isLogin});
}

class SplashLoadFailure extends SplashState {}
