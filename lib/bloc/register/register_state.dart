part of 'register_bloc.dart';

@immutable
class RegisterState  extends Equatable{

  final RegisterStatus status;

  const RegisterState._({this.status = RegisterStatus.Initial});
  const RegisterState.loading():this._(status:RegisterStatus.Loading);
  const RegisterState.failure():this._(status:RegisterStatus.RegisterFailure);
  const RegisterState.alreadyInUse():this._(status:RegisterStatus.AlreadyInUse);
  const RegisterState.complete():this._(status:RegisterStatus.RegisterComplete);

  @override
  List<Object> get props =>[status];
}

