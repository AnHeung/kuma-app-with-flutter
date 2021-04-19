import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SearchMalCharacterDetailItem {
  bool err;
  String msg;
  Result result;

  SearchMalCharacterDetailItem({this.err, this.msg, this.result});

  SearchMalCharacterDetailItem.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    result = json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['err'] = this.err;
    data['msg'] = this.msg;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String characterId;
  String name;
  String nameKanji;
  String nicknames;
  String about;
  String imageUrl;
  String url;
  List<RelateAnimation> relateAnimation;
  List<VoiceActors> voiceActors;
  String favoritesRank;

  Result(
      {this.characterId,
        this.name,
        this.nameKanji,
        this.nicknames,
        this.about,
        this.imageUrl,
        this.url,
        this.relateAnimation,
        this.voiceActors,
        this.favoritesRank});

  Result.fromJson(Map<String, dynamic> json) {
    characterId = json['character_id'];
    name = json['name'];
    nameKanji = json['name_kanji'];
    nicknames = json['nicknames'];
    about = json['about'];
    imageUrl = json['image_url'];
    url = json['url'];
    if (json['relate_animation'] != null) {
      relateAnimation = new List<RelateAnimation>();
      json['relate_animation'].forEach((v) {
        relateAnimation.add(new RelateAnimation.fromJson(v));
      });
    }
    if (json['voice_actors'] != null) {
      voiceActors = new List<VoiceActors>();
      json['voice_actors'].forEach((v) {
        voiceActors.add(new VoiceActors.fromJson(v));
      });
    }
    favoritesRank = json['favorites_rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['character_id'] = this.characterId;
    data['name'] = this.name;
    data['name_kanji'] = this.nameKanji;
    data['nicknames'] = this.nicknames;
    data['about'] = this.about;
    data['image_url'] = this.imageUrl;
    data['url'] = this.url;
    if (this.relateAnimation != null) {
      data['relate_animation'] =
          this.relateAnimation.map((v) => v.toJson()).toList();
    }
    if (this.voiceActors != null) {
      data['voice_actors'] = this.voiceActors.map((v) => v.toJson()).toList();
    }
    data['favorites_rank'] = this.favoritesRank;
    return data;
  }
}

class RelateAnimation {
  String id;
  String title;
  String imageUrl;

  RelateAnimation({this.id, this.title, this.imageUrl});

  RelateAnimation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class VoiceActors {
  String id;
  String name;
  String imageUrl;
  String country;
  String url;

  VoiceActors({this.id, this.name, this.imageUrl, this.country, this.url});

  VoiceActors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
    country = json['country'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image_url'] = this.imageUrl;
    data['country'] = this.country;
    data['url'] = this.url;
    return data;
  }
}
