class AnimationDetailItem {

  int id;
  String title;
  String image;
  String startDate;
  String endDate;
  String star;
  String popularity;
  int rank;
  String synopsis;
  String status;
  String genres;
  String numEpisodes;
  String startSeason;
  List<RelatedAnimeItem> relatedAnime;

  AnimationDetailItem(
      {this.id,
        this.title,
        this.image,
        this.startDate,
        this.endDate,
        this.star,
        this.popularity,
        this.rank,
        this.synopsis,
        this.status,
        this.genres,
        this.numEpisodes,
        this.startSeason,
        this.relatedAnime});

}

class RelatedAnimeItem {
  int id;
  String title;
  String image;

  RelatedAnimeItem({this.id, this.title, this.image});

}