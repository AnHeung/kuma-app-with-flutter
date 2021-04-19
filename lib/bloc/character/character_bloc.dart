import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_detail_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_character_detail_item.dart';
import 'package:kuma_flutter_app/model/item/animation_character_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {

  final ApiRepository repository;

  CharacterBloc({this.repository}) : super(CharacterState(status: CharacterStatus.initial));

  @override
  Stream<CharacterState> mapEventToState(
    CharacterEvent event,
  ) async* {
    if(event is CharacterLoad){
      yield* _mapToCharacterLoad(event);
    }
  }

  Stream<CharacterState> _mapToCharacterLoad(CharacterLoad event)async*{
    String characterId = event.characterId;
    SearchMalCharacterDetailItem characterDetailItem = await repository.getCharacterInfo(characterId);
    print(characterDetailItem);
  }
}
