part of 'splash_bloc.dart';

@immutable
abstract class SplashState extends Equatable{
  @override
  List<Object> get props =>[];
}

class SplashLoadInProgress extends SplashState {}

class SplashLoadSuccess extends SplashState {}

class SplashLoadFailure extends SplashState {}
