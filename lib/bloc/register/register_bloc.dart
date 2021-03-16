import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/enums/register_status.dart';
import 'package:kuma_flutter_app/model/api/social_user.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/sharepref_util.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  final ApiRepository repository;

  RegisterBloc({this.repository}) : super(RegisterState._());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if(event is UserRegister){
      yield* _mapToUserRegister(event);
    }
  }

  Stream<RegisterState> _mapToUserRegister(UserRegister event) async*{
    yield RegisterState.loading();
    SocialUserData userData = event.userData;
    print('넘어온 userData :$userData');

    if(userData!= null && userData.uniqueId.isNotEmpty && userData.email.isNotEmpty){

      RegisterStatus status = await repository.register(userData: userData);
      await Future.delayed(Duration(seconds: 1));

      if(status == RegisterStatus.RegisterComplete){
        await saveUserData(userData: userData);
        yield RegisterState.complete();
      }else if(status == RegisterStatus.AlreadyInUse){
        yield RegisterState.alreadyInUse();
      }else if(status == RegisterStatus.RegisterFailure){
        yield RegisterState.failure();
      }
    }
  }
}
