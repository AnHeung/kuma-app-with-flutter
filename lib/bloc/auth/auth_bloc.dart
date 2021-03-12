import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final ApiRepository repository;
  StreamSubscription subscription;

  AuthBloc({this.repository}) : super(const AuthState.unKnown()){

    subscription = repository.user.listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
        add(ChangeAuth(status: AuthStatus.UnAuth));
      } else {
        print('User is signed in!');
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
}
