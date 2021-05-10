import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/model/item/animation_character_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';

part 'animation_character_event.dart';
part 'animation_character_state.dart';

class AnimationCharacterBloc extends Bloc<AnimationCharacterEvent, AnimationCharacterState> {

  final ApiRepository repository;

  AnimationCharacterBloc({this.repository}) : super(const AnimationCharacterState(status: AnimationCharacterStatus.initial));

  @override
  Stream<AnimationCharacterState> mapEventToState(
    AnimationCharacterEvent event,
  ) async* {
  }
}
