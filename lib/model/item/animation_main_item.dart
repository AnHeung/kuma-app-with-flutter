class AnimationMainItem {
  String type;
  String koreaType;
  List<RankingItem> list;

  AnimationMainItem({this.type, this.list ,this.koreaType});

}

class RankingItem {
  String id;
  String title;
  String image;
  String ranking;
  String score;

  RankingItem({this.id, this.title, this.image, this.ranking,this.score});

}