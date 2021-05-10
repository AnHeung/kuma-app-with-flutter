import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/model/api/search_mal_character_detail_item.dart';
import 'package:kuma_flutter_app/model/item/animation_character_detail_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';

import '../../model/item/animation_character_detail_item.dart';
import '../../model/item/animation_detail_item.dart';

part 'character_detail_event.dart';
part 'character_detail_state.dart';

class CharacterDetailBloc extends Bloc<CharacterDetailEvent, CharacterState> {

  final ApiRepository repository;

  CharacterDetailBloc({this.repository}) : super(CharacterState(status: CharacterDetailStatus.initial));

  @override
  Stream<CharacterState> mapEventToState(
      CharacterDetailEvent event,
  ) async* {
    if(event is CharacterDetailLoad){
      yield* _mapToCharacterLoad(event);
    }
  }

  Stream<CharacterState> _mapToCharacterLoad(CharacterDetailLoad event)async*{
    yield CharacterState(status: CharacterDetailStatus.loading);
    String characterId = event.characterId;
    SearchMalCharacterDetailItem characterDetailItem = await repository.getCharacterInfo(characterId);
    if(characterDetailItem.err){
      yield CharacterState(status: CharacterDetailStatus.failure , msg: characterDetailItem.msg);
    }else{

      final List<RelatedAnimeItem> relateItems = characterDetailItem.result.relateAnimation!= null ? characterDetailItem.result.relateAnimation.map((item) => RelatedAnimeItem(id: item.id ,image: item.imageUrl , title: item.title)).toList() :[];
      final List<VoiceActorItem> voiceItems =characterDetailItem.result.voiceActors!= null ? characterDetailItem.result.voiceActors.map((item) => VoiceActorItem(name: item.name ,image: item.imageUrl , id: item.id)).toList() : [];
      final List<CharacterPictureItem> characterPictureItems = characterDetailItem.result.pictures!= null ? characterDetailItem.result.pictures.map((item) => CharacterPictureItem(image: item.image)).toList() : [];

      yield CharacterState(status: CharacterDetailStatus.success , characterItem: AnimationCharacterDetailItem(about:characterDetailItem.result.about , characterId: characterDetailItem.result.characterId,
        favoritesRank: characterDetailItem.result.favoritesRank ,imageUrl: characterDetailItem.result.imageUrl , name: characterDetailItem.result.name , nameKanji: "(${characterDetailItem.result.nameKanji})",
      nicknames:characterDetailItem.result.nicknames , relateAnimation:relateItems
          , url: characterDetailItem.result.url, voiceActors: voiceItems, pictureItems: characterPictureItems));
    }
  }
}
