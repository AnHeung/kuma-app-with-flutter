import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/sharepref_util.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final ApiRepository repository;
  StreamSubscription subscription;

  AuthBloc({this.repository}) : super(const AuthState.unKnown()){

    subscription = repository.userStream.listen((User user) {
      if (user == null) {
        print('유저가 로그아웃 하였습니다.');
        add(ChangeAuth(status: AuthStatus.UnAuth));
      } else {
        print('유저가 로그인 하였습니다.');
        add(ChangeAuth(status: AuthStatus.Auth));
      }
    });
  }


  @override
  Future<Function> close() {
    subscription?.cancel();
    return super.close();
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if(event is ChangeAuth){
      yield* _mapToChangeAuth(event);
    }else if(event is SignOut){
      yield* _mapToSignOut();
    }
  }

  Stream<AuthState> _mapToChangeAuth(ChangeAuth event) async*{

    AuthStatus status = event.status;

    switch(status){
      case AuthStatus.Auth:
        yield AuthState.auth();
        break;
      case AuthStatus.UnAuth:
        yield AuthState.unAuth();
        break;
      case AuthStatus.UnKnown:
        yield AuthState.unKnown();
        break;
    }
  }

  Stream<AuthState> _mapToSignOut() async*{
    yield AuthState.unKnown();
    bool logoutSuccess = await repository.logout();
    if(logoutSuccess) await removeUserData();
    else yield AuthState.unAuth();
  }
}
