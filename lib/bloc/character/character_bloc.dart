import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_detail_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_character_detail_item.dart';
import 'package:kuma_flutter_app/model/item/animation_character_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';

import '../../model/item/animation_character_item.dart';
import '../../model/item/animation_character_item.dart';
import '../../model/item/animation_character_item.dart';
import '../../model/item/animation_detail_item.dart';
import '../../model/item/animation_detail_item.dart';

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
    yield CharacterState(status: CharacterStatus.loading);
    String characterId = event.characterId;
    SearchMalCharacterDetailItem characterDetailItem = await repository.getCharacterInfo(characterId);
    if(characterDetailItem.err){
      yield CharacterState(status: CharacterStatus.failure , msg: characterDetailItem.msg);
    }else{

      final List<RelatedAnimeItem> relateItems = characterDetailItem.result.relateAnimation!= null ? characterDetailItem.result.relateAnimation.map((item) => RelatedAnimeItem(id: item.id ,image: item.imageUrl , title: item.title)).toList() :[];
      final List<VoiceActorItem> voiceItems =characterDetailItem.result.voiceActors!= null ? characterDetailItem.result.voiceActors.map((item) => VoiceActorItem(name: item.name ,image: item.imageUrl , id: item.id)).toList() : [];
      final List<CharacterPictureItem> characterPictureItems = characterDetailItem.result.pictures!= null ? characterDetailItem.result.pictures.map((item) => CharacterPictureItem(image: item.image)).toList() : [];

      yield CharacterState(status: CharacterStatus.success , characterItem: AnimationCharacterItem(about:characterDetailItem.result.about , characterId: characterDetailItem.result.characterId,
        favoritesRank: characterDetailItem.result.favoritesRank ,imageUrl: characterDetailItem.result.imageUrl , name: characterDetailItem.result.name , nameKanji: "(${characterDetailItem.result.nameKanji})",
      nicknames:characterDetailItem.result.nicknames , relateAnimation:relateItems
          , url: characterDetailItem.result.url, voiceActors: voiceItems, pictureItems: characterPictureItems));
    }
  }
}
