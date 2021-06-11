class AnimationDetailItem {
  final String id;
  final String title;
  final String titleEn;
  final String image;
  final String startDate;
  final String endDate;
  final String star;
  final String popularity;
  final String rank;
  final String percent;
  final String percentText;
  final String synopsis;
  final String status;
  final List<AnimationDetailGenreItem> genres;
  final String numEpisodes;
  final String startSeason;
  final List<String> pictures;
  final List<RelatedAnimeItem> relatedAnime;
  final List<RecommendationAnimeItem> recommendationAnimes;
  final List<StudioItem> studioItems;
  final List<VideoItem> videoItems;
  final List<CharacterItem> characterItems;
  final String selectVideoUrl;

  const AnimationDetailItem(
      {this.id,
      this.title,
      this.titleEn,
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
      this.videoItems,
      this.characterItems,
      this.selectVideoUrl});

  static const empty = AnimationDetailItem(
      id: "",
      videoItems: [],
      status: "",
      characterItems: [],
      title: "",
      titleEn: "",
      endDate: "",
      startDate: "",
      image: "",
      studioItems: [],
      recommendationAnimes: [],
      genres: [],
      pictures: [],
      percentText: "",
      percent: "0.0",
      relatedAnime: [],
      startSeason: "",
      numEpisodes: "",
      synopsis: "",
      rank: "",
      popularity: "",
      star: "",
      selectVideoUrl: "");

  AnimationDetailItem copyWith(
      {id,
      title,
      titleEn,
      image,
      startDate,
      endDate,
      star,
      popularity,
      rank,
      percent,
      percentText,
      synopsis,
      status,
      genres,
      numEpisodes,
      startSeason,
      pictures,
      relatedAnime,
      recommendationAnimes,
      studioItems,
      videoItems,
      characterItems,
      selectVideoUrl}) {
    return AnimationDetailItem(
        id: id ?? this.id,
        star: star ?? this.star,
        popularity: popularity ?? this.popularity,
        rank: rank ?? this.rank,
        synopsis: synopsis ?? this.synopsis,
        numEpisodes: numEpisodes ?? this.numEpisodes,
        startSeason: startSeason ?? this.startSeason,
        relatedAnime: relatedAnime ?? this.relatedAnime,
        percent: percent ?? this.percent,
        percentText: percentText ?? this.percentText,
        pictures: pictures ?? this.pictures,
        genres: genres ?? this.genres,
        recommendationAnimes: recommendationAnimes ?? this.recommendationAnimes,
        studioItems: studioItems ?? this.studioItems,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        title: title ?? this.title,
        titleEn: titleEn ?? this.titleEn,
        characterItems: characterItems ?? this.characterItems,
        status: status ?? this.status,
        videoItems: videoItems ?? this.videoItems,
        image: image ?? this.image,
        selectVideoUrl: selectVideoUrl ?? this.selectVideoUrl);
  }
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

class VideoItem {
  final String title;
  final String imageUrl;
  final String videoUrl;

  const VideoItem({this.title, this.imageUrl, this.videoUrl});
}

class CharacterItem {
  String characterId;
  String name;
  String role;
  String imageUrl;
  String url;

  CharacterItem(
      {this.characterId, this.name, this.role, this.imageUrl, this.url});
}
