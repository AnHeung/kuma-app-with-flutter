class SearchMalPersonItem {
  bool err;
  String msg;
  Result result;

  SearchMalPersonItem({this.err, this.msg, this.result});

  SearchMalPersonItem.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
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
  String personId;
  String name;
  String familyName;
  String givenName;
  String birthday;
  String alternateNames;
  String about;
  String imageUrl;
  String url;
  List<VoiceActingRoles> voiceActingRoles;
  String favoritesRank;

  Result(
      {this.personId,
        this.name,
        this.familyName,
        this.givenName,
        this.birthday,
        this.alternateNames,
        this.about,
        this.imageUrl,
        this.url,
        this.voiceActingRoles,
        this.favoritesRank});

  Result.fromJson(Map<String, dynamic> json) {
    personId = json['person_id'];
    name = json['name'];
    familyName = json['family_name'];
    givenName = json['given_name'];
    birthday = json['birthday'];
    alternateNames = json['alternate_names'];
    about = json['about'];
    imageUrl = json['image_url'];
    url = json['url'];
    if (json['voice_acting_roles'] != null) {
      voiceActingRoles = [];
      json['voice_acting_roles'].forEach((v) {
        voiceActingRoles.add(new VoiceActingRoles.fromJson(v));
      });
    }
    favoritesRank = json['favorites_rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['person_id'] = this.personId;
    data['name'] = this.name;
    data['family_name'] = this.familyName;
    data['given_name'] = this.givenName;
    data['birthday'] = this.birthday;
    data['alternate_names'] = this.alternateNames;
    data['about'] = this.about;
    data['image_url'] = this.imageUrl;
    data['url'] = this.url;
    if (this.voiceActingRoles != null) {
      data['voice_acting_roles'] =
          this.voiceActingRoles.map((v) => v.toJson()).toList();
    }
    data['favorites_rank'] = this.favoritesRank;
    return data;
  }
}

class VoiceActingRoles {
  String role;
  Anime anime;
  Character character;

  VoiceActingRoles({this.role, this.anime, this.character});

  VoiceActingRoles.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    anime = json['anime'] != null ? new Anime.fromJson(json['anime']) : null;
    character = json['character'] != null
        ? new Character.fromJson(json['character'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    if (this.anime != null) {
      data['anime'] = this.anime.toJson();
    }
    if (this.character != null) {
      data['character'] = this.character.toJson();
    }
    return data;
  }
}

class Anime {
  String malId;
  String url;
  String imageUrl;
  String name;

  Anime({this.malId, this.url, this.imageUrl, this.name});

  Anime.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    url = json['url'];
    imageUrl = json['image_url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mal_id'] = this.malId;
    data['url'] = this.url;
    data['image_url'] = this.imageUrl;
    data['name'] = this.name;
    return data;
  }
}

class Character {
  String characterId;
  String url;
  String imageUrl;
  String name;

  Character({this.characterId, this.url, this.imageUrl, this.name});

  Character.fromJson(Map<String, dynamic> json) {
    characterId = json['character_id'];
    url = json['url'];
    imageUrl = json['image_url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['character_id'] = this.characterId;
    data['url'] = this.url;
    data['image_url'] = this.imageUrl;
    data['name'] = this.name;
    return data;
  }
}