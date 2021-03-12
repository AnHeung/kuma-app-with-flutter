part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable{

  @override
  List<Object> get props =>[];

  const AuthEvent();

}

class ChangeAuth extends AuthEvent{

  final AuthStatus status;
  const ChangeAuth({this.status});

}
