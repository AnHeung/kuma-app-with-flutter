class AnimationMainItem {
  String type;
  String koreaType;
  List<RankingItem> list;

  AnimationMainItem({this.type, this.list ,this.koreaType});

}

class RankingItem {
  int id;
  String title;
  String image;
  int ranking;

  RankingItem({this.id, this.title, this.image, this.ranking});

}