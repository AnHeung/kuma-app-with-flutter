part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable{



  @override
  List<Object> get props =>[];

  const RegisterEvent();

}

class UserRegister extends RegisterEvent{

  final LoginUserData userData;

  const UserRegister({this.userData});

  @override
  List<Object> get props =>[];
}
