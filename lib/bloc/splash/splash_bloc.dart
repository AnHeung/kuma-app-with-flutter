import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/sharepref_util.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {

  final ApiRepository repository;

  SplashBloc({this.repository}) : super(SplashLoadInProgress());

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if(event is SplashInit){
      yield* _mapToSplashInit(event);
    }
  }

  Stream<SplashState> _mapToSplashInit(SplashInit event) async*{
      await printUserData();
      await Future.delayed(Duration(seconds: 2));
      yield SplashLoadSuccess();
  }
}
