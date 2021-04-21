class AnimationPersonItem {
  final String personId;
  final String name;
  final String familyName;
  final String givenName;
  final String birthday;
  final String alternateNames;
  final String about;
  final String imageUrl;
  final String url;
  final List<RoleItem> voiceActingRoles;
  final String favoritesRank;

  const AnimationPersonItem({this.personId,
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

  static const empty = AnimationPersonItem(personId: "" ,name: "",familyName :"" , givenName: "" ,birthday:"" , alternateNames:"", about:"",imageUrl:"" , url: "", voiceActingRoles: [],favoritesRank: "");
}

class RoleItem {
  String role;
  PersonAnimationItem animationItem;
  PersonCharacterItem characterItem;

  RoleItem({this.role, this.animationItem, this.characterItem});
}

class PersonAnimationItem {
  final String malId;
  final String url;
  final String imageUrl;
  final String name;

  PersonAnimationItem({this.malId, this.url, this.imageUrl, this.name});
}

class PersonCharacterItem {
  final String characterId;
  final String url;
  final String imageUrl;
  final String name;

  PersonCharacterItem({this.characterId, this.url, this.imageUrl, this.name});
}
