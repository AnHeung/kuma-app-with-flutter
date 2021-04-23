import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/sharepref_util.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final ApiRepository repository;

  SplashBloc({this.repository})
      : super(const SplashState(status: SplashStatus.initial));

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if (event is SplashLoad) {
      yield* _mapToSplashInit();
    }
  }

  Stream<SplashState> _mapToSplashInit() async* {
    await Future.delayed(const Duration(seconds: kSplashTime));
    yield const SplashState(status: SplashStatus.loading);
    await printUserData();
    bool isAppFirstLaunch = await appFirstLaunch();
    await Future.delayed(const Duration(seconds: 1));
    yield SplashState(
        isAppFirstLaunch: isAppFirstLaunch, status: SplashStatus.success);
  }
}
