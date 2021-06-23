import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';

part 'more_event.dart';
part 'more_state.dart';

class MoreBloc extends Bloc<MoreEvent, MoreState> {

  final ApiRepository repository;

  MoreBloc({this.repository}) : super(const MoreState(msg: "",status: MoreStatus.Initial));

  @override
  Stream<MoreState> mapEventToState(
    MoreEvent event,
  ) async* {
    if(event is MoreSignOut){
      // yield* _mapToSignOut();
    }
  }

  // Stream<MoreState> _mapToSignOut() async*{
  //   yield MoreLoadingInProgress();
  //   bool logoutSuccess = await repository.logout();
  //   if(logoutSuccess) yield MoreNeedLogin();
  //   else yield MoreLoadFailure();
  // }
}
