class AnimationCharacterItem {

  final String characterId;
  final String name;
  final String role;
  final String imageUrl;
  final String url;

  const AnimationCharacterItem({
      this.characterId,
      this.name,
      this.role,
      this.imageUrl,
      this.url,});


  static const empty = AnimationCharacterItem(characterId: "" , url: "",name:"", imageUrl :"",);
}