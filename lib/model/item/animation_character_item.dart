import 'package:kuma_flutter_app/model/item/animation_detail_item.dart';

class AnimationCharacterItem {
  String characterId;
  String name;
  String nameKanji;
  String nicknames;
  String about;
  String imageUrl;
  String url;
  List<RelatedAnimeItem> relateAnimation;
  List<VoiceActorItem> voiceActors;
  String favoritesRank;

  AnimationCharacterItem({
      this.characterId,
      this.name,
      this.nameKanji,
      this.nicknames,
      this.about,
      this.imageUrl,
      this.url,
      this.relateAnimation,
      this.voiceActors,
      this.favoritesRank});
}

class VoiceActorItem {
  String id;
  String title;
  String image;

  VoiceActorItem({this.id, this.title, this.image});
}