import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/model/api/login_user.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  final ApiRepository repository;

  RegisterBloc({this.repository}) : super(RegisterState(status: RegisterStatus.Initial));

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if(event is UserRegister){
      yield* _mapToUserRegister(event);
    }
  }

  Stream<RegisterState> _mapToUserRegister(UserRegister event) async*{
    try {
      yield RegisterState(status: RegisterStatus.Loading);
      LoginUserData userData = event.userData;
      if(userData!= null && userData.uniqueId.isNotEmpty && userData.userId.isNotEmpty){
            RegisterStatus status = await repository.register(userData: userData);
            await Future.delayed(const Duration(seconds: 1));
            yield RegisterState(status: status);
          }
    } catch (e) {
      print("_mapToUserRegister $e");
      yield RegisterState(status: RegisterStatus.RegisterFailure);
    }
  }
}
