import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:kuma_flutter_app/enums/login_status.dart';
import 'package:kuma_flutter_app/model/api/social_user.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiRepository repository;

  LoginBloc({this.repository}) : super(const LoginState._());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event,) async* {
    if (event is Login) {
      yield* _mapToLogin(event);
    } else if (event is DirectLogin) {
      yield* _mapToDirectLogin(event);
    }
  }

  Stream<LoginState> _mapToDirectLogin(DirectLogin event) async* {
    yield const LoginState.loading();
    Map<LoginStatus, LoginUserData> loginData = await repository.firebaseSignIn(
        userData: event.userData);
    yield getLoginStatus(loginData);
  }

  Stream<LoginState> _mapToLogin(Login event) async* {
    yield const LoginState.loading();
    Map<LoginStatus, LoginUserData> loginData = await repository.login(
        context: event.context, type: event.type);
    yield getLoginStatus(loginData);
  }

  LoginState getLoginStatus(Map<LoginStatus, LoginUserData> loginData)  {
    try {
      final LoginStatus status = loginData.keys.first;
      final LoginUserData data = loginData.values.first;

      switch (status) {
        case LoginStatus.NeedRegister:
          return LoginState.needRegister(userData: data);
        case LoginStatus.LoginSuccess:
          return const LoginState.success();
        case LoginStatus.WrongPassword:
          return const LoginState.wrongPassword();
        case LoginStatus.Failure:
          return const LoginState.failure();
        case LoginStatus.CheckEmail:
          return const LoginState.checkEmail();
        case LoginStatus.NeedLoginScreen:
          return const LoginState.needLoginScreen();
        default:
          return const LoginState._();
      }
    } on Exception catch (e) {
      print('_mapToLogin Error:$e}');
      return const LoginState.failure();
    }
  }
}