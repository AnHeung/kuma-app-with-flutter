class SearchMalDetailApiItem {
  bool err;
  String msg;
  SearchMalDetailApiItemResult result;

  SearchMalDetailApiItem({this.err, this.msg, this.result});

  SearchMalDetailApiItem.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    result = json['result'] != null ? new SearchMalDetailApiItemResult.fromJson(json['result']) : null;
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

class SearchMalDetailApiItemResult {
  String id;
  String title;
  String titleEn;
  String image;
  String startDate;
  String endDate;
  String star;
  String popularity;
  String rank;
  String synopsis;
  String status;
  List<SearchMalDetailGenreItem> genres;
  String numEpisodes;
  String startSeason;
  List<String> pictures;
  List<SearchMalDetailRelatedAnimeItem> relatedAnime;
  List<SearchMalDetailRecommendationAnimeItem> recommendAnime;
  List<SearchMalDetailStudioItem> studios;
  List<SearchMalDetailVideoItem> videos;
  List<SearchMalDetailCharacterItem> characters;

  SearchMalDetailApiItemResult(
      {this.id,
        this.title,
        this.titleEn,
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
        this.pictures,
        this.relatedAnime,
        this.recommendAnime,
        this.studios , this.videos ,this.characters});

  SearchMalDetailApiItemResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    titleEn = json['title_en'];
    image = json['image'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    star = json['star'];
    popularity = json['popularity'];
    rank = json['rank'];
    synopsis = json['synopsis'];
    status = json['status'];
    if (json['genres'] != null) {
      genres = [];
      json['genres'].forEach((v) {
        genres.add(new SearchMalDetailGenreItem.fromJson(v));
      });
    }
    numEpisodes = json['num_episodes'];
    startSeason = json['start_season'];
    pictures = json['pictures'].cast<String>();
    if (json['related_anime'] != null) {
      relatedAnime = [];
      json['related_anime'].forEach((v) {
        relatedAnime.add(new SearchMalDetailRelatedAnimeItem.fromJson(v));
      });
    }
    if (json['recommendations'] != null) {
      recommendAnime = [];
      json['recommendations'].forEach((v) {
        recommendAnime.add(new SearchMalDetailRecommendationAnimeItem.fromJson(v));
      });
    }
    if (json['studios'] != null) {
      studios = [];
      json['studios'].forEach((v) {
        studios.add(new SearchMalDetailStudioItem.fromJson(v));
      });
    }
    if (json['videos'] != null) {
      videos = [];
      json['videos'].forEach((v) {
        videos.add(new SearchMalDetailVideoItem.fromJson(v));
      });
    }
    if (json['characters'] != null) {
      characters = [];
      json['characters'].forEach((v) {
        characters.add(new SearchMalDetailCharacterItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['titleEn'] = this.titleEn;
    data['image'] = this.image;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['star'] = this.star;
    data['popularity'] = this.popularity;
    data['rank'] = this.rank;
    data['synopsis'] = this.synopsis;
    data['status'] = this.status;
    data['genres'] = this.genres;
    data['num_episodes'] = this.numEpisodes;
    data['start_season'] = this.startSeason;
    data['pictures'] = this.pictures;
    if (this.relatedAnime != null) {
      data['related_anime'] = this.relatedAnime.map((v) => v.toJson()).toList();
    }
    if (this.recommendAnime != null) {
      data['recommendations'] = this.recommendAnime.map((v) => v.toJson()).toList();
    }
    if (this.studios != null) {
      data['studios'] = this.studios.map((v) => v.toJson()).toList();
    }
    if (this.videos != null) {
      data['videos'] = this.videos.map((v) => v.toJson()).toList();
    }
    if (this.characters != null) {
      data['characters'] = this.characters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchMalDetailGenreItem {
  String id;
  String name;

  SearchMalDetailGenreItem({this.id, this.name});

  SearchMalDetailGenreItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class SearchMalDetailRelatedAnimeItem {
  String id;
  String title;
  String image;

  SearchMalDetailRelatedAnimeItem({this.id, this.title, this.image});

  SearchMalDetailRelatedAnimeItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    return data;
  }
}

class SearchMalDetailRecommendationAnimeItem {
  String id;
  String title;
  String image;

  SearchMalDetailRecommendationAnimeItem({this.id, this.title, this.image});

  SearchMalDetailRecommendationAnimeItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    return data;
  }
}

class SearchMalDetailStudioItem {
  String id;
  String name;

  SearchMalDetailStudioItem({this.id, this.name});

  SearchMalDetailStudioItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class SearchMalDetailVideoItem{
  String title;
  String image_url;
  String video_url;

  SearchMalDetailVideoItem({this.title, this.image_url, this.video_url});

  SearchMalDetailVideoItem.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image_url = json['image_url'];
    video_url = json['video_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image_url'] = this.image_url;
    data['video_url'] = this.video_url;
    return data;
  }
}

class SearchMalDetailCharacterItem{
  String character_id;
  String name;
  String role;
  String image_url;
  String url;

  SearchMalDetailCharacterItem({
      this.character_id, this.name, this.role, this.image_url, this.url});

  SearchMalDetailCharacterItem.fromJson(Map<String, dynamic> json) {
    character_id = json['character_id'];
    name = json['name'];
    role = json['role'];
    image_url = json['image_url'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['character_id'] = this.character_id;
    data['name'] = this.name;
    data['role'] = this.role;
    data['image_url'] = this.image_url;
    data['url'] = this.url;
    return data;
  }
}
