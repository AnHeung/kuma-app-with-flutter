import 'package:kuma_flutter_app/model/item/animation_detail_item.dart';

class AnimationCharacterItem {
  final String characterId;
  final String name;
  final String nameKanji;
  final String nicknames;
  final String about;
  final String imageUrl;
  final String url;
  final List<RelatedAnimeItem> relateAnimation;
  final  List<VoiceActorItem> voiceActors;
  final  List<CharacterPictureItem> pictureItems;
  final String favoritesRank;

  const AnimationCharacterItem({
      this.characterId,
      this.name,
      this.nameKanji,
      this.nicknames,
      this.about,
      this.imageUrl,
      this.url,
      this.relateAnimation,
      this.voiceActors,
    this.pictureItems,
      this.favoritesRank});


  static const empty = AnimationCharacterItem(characterId: "" , url: "", voiceActors: [],relateAnimation: [], nicknames: "",nameKanji: "",name: "",imageUrl: "", about: "",pictureItems:[],favoritesRank: "");
}

class VoiceActorItem {
  String id;
  String name;
  String image;

  VoiceActorItem({this.id, this.name, this.image});
}


class CharacterPictureItem {
  String image;

  CharacterPictureItem({this.image});
}