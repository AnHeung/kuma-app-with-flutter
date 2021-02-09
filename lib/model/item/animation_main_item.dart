class AnimationMainItem {
  String type;
  List<RankingItem> list;

  AnimationMainItem({this.type, this.list});

}

class RankingItem {
  int id;
  String title;
  String image;
  int ranking;

  RankingItem({this.id, this.title, this.image, this.ranking});

}