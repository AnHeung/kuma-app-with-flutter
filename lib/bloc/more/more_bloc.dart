import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'more_event.dart';
part 'more_state.dart';

class MoreBloc extends Bloc<MoreEvent, MoreState> {
  MoreBloc() : super(MoreInitial());

  @override
  Stream<MoreState> mapEventToState(
    MoreEvent event,
  ) async* {
  }
}
