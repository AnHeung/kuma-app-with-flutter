import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';

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
      print('테스트');
      await Future.delayed(Duration(seconds: 2));
      yield SplashLoadSuccess();
  }
}
