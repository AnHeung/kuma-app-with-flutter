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

  static const empty = AnimationPersonItem(personId: "" ,familyName :"" , givenName: "" ,birthday:"" , alternateNames:"", about:"",imageUrl:"" , url: "", voiceActingRoles: [],favoritesRank: "");
}

class RoleItem {
  String role;
  PersonAnimationItem animationItem;
  PersonCharacterItem characterItem;

  RoleItem({this.role, this.animationItem, this.characterItem});
}

class PersonAnimationItem {
  String malId;
  String url;
  String imageUrl;
  String name;
}

class PersonCharacterItem {
  String characterId;
  String url;
  String imageUrl;
  String name;
}
