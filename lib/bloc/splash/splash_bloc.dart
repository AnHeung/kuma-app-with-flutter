import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/auth/auth_bloc.dart';
import 'package:kuma_flutter_app/bloc/network/network_bloc.dart';
import 'package:kuma_flutter_app/model/api/login_user.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/common.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final ApiRepository repository;
  final AuthBloc authBloc;
  final NetworkBloc networkBloc;

  SplashBloc({@required this.repository, this.authBloc, @required this.networkBloc})
      : super(const SplashState());

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
    yield const SplashState(status: SplashStatus.Loading);
    if (await isNetworkConnect()) {
      String userId = await getUserId();
      LoginUserData userData = await repository.getUserItemFromFireStore(userId: userId);
      if (userData != null) {
        await saveUserData(userData: userData);
      } else {
        await removeUserData();
        authBloc.add(const ChangeAuth(status: AuthStatus.UnAuth));
      }
      await printUserData();
      bool isAppFirstLaunch = await appFirstLaunch();
      await Future.delayed(const Duration(seconds: 1));
      yield SplashState(
          isAppFirstLaunch: isAppFirstLaunch, status: SplashStatus.Success);
    }else{
      yield const SplashState(status: SplashStatus.NetworkError , msg: "네트워크 접속 에러 다시시도해 주세요");
    }
  }
}
