class AnimationDetailItem {

  String id;
  String title;
  String image;
  String startDate;
  String endDate;
  String star;
  String popularity;
  String rank;
  String percent;
  String percentText;
  String synopsis;
  String status;
  List<AnimationDetailGenreItem> genres;
  String numEpisodes;
  String startSeason;
  List<String> pictures;
  List<RelatedAnimeItem> relatedAnime;
  List<RecommendationAnimeItem> recommendationAnimes;
  List<StudioItem> studioItems;

  AnimationDetailItem(
      {this.id,
        this.title,
        this.image,
        this.startDate,
        this.endDate,
        this.star,
        this.popularity,
        this.rank,
        this.percent,
        this.percentText,
        this.synopsis,
        this.status,
        this.genres,
        this.numEpisodes,
        this.startSeason,
        this.pictures,
        this.relatedAnime,
        this.recommendationAnimes,
        this.studioItems,
      });

}

class RelatedAnimeItem {
  String id;
  String title;
  String image;

  RelatedAnimeItem({this.id, this.title, this.image});
}

class RecommendationAnimeItem {
  String id;
  String title;
  String image;

  RecommendationAnimeItem({this.id, this.title, this.image});
}
class StudioItem {
  String id;
  String name;

  StudioItem({this.id, this.name});
}

class AnimationDetailGenreItem {
  String id;
  String name;

  AnimationDetailGenreItem({this.id, this.name});
}