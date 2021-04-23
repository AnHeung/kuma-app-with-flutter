part of 'register_bloc.dart';

@immutable
class RegisterState  extends Equatable{

  final RegisterStatus status;

  RegisterState({this.status = RegisterStatus.Initial});

  @override
  List<Object> get props =>[status];
}

