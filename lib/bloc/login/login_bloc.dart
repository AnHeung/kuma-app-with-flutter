import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:kuma_flutter_app/model/api/login_user.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiRepository repository;

  LoginBloc({this.repository}) : super(const LoginState(status: LoginStatus.Initial));

  @override
  Stream<LoginState> mapEventToState(LoginEvent event,) async* {
    if (event is Login) {
      yield* _mapToLogin(event);
    } else if (event is DirectLogin) {
      yield* _mapToDirectLogin(event);
    }
  }

  Stream<LoginState> _mapToDirectLogin(DirectLogin event) async* {
    try {
      yield const LoginState(status: LoginStatus.Loading);
      Map<LoginStatus, LoginUserData> loginData = await repository.firebaseSignIn(
              userData: event.userData);
      yield* getLoginStatus(loginData);
    } catch (e) {
      print("_mapToDirectLogin Error : $e");
      yield LoginState(status: LoginStatus.Failure, msg: "로그인 에러 $e");
    }
  }

  Stream<LoginState> _mapToLogin(Login event) async* {
    try {
      yield const LoginState(status: LoginStatus.Loading);
      Map<LoginStatus, LoginUserData> loginData = await repository.login(
              context: event.context, type: event.type);
      yield* getLoginStatus(loginData);
    } catch (e) {
      print("_mapToLogin Error : $e");
      yield LoginState(status: LoginStatus.Failure, msg: "로그인 에러 $e");
    }
  }

  Stream<LoginState> getLoginStatus(Map<LoginStatus, LoginUserData> loginData)  async*{
    try {
      final LoginStatus status = loginData.keys.first;
      final LoginUserData data = loginData.values.first;

      yield LoginState(status:status,userData: data);
    } on Exception catch (e) {
      print('getLoginStatus Error:$e');
      yield LoginState(status: LoginStatus.Failure, msg:'getLoginStatus 에러:$e');
    }
  }
}