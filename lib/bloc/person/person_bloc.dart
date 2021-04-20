import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/model/item/animation_person_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {

  final ApiRepository repository;

  PersonBloc({this.repository}) : super(PersonState(status: PersonStateStatus.initial));

  @override
  Stream<PersonState> mapEventToState(
    PersonEvent event,
  ) async* {
  }
}
