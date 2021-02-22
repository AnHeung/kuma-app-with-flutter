import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
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
  List<String> pictures;
  List<SearchMalDetailRelatedAnimeItem> relatedAnime;

  SearchMalDetailApiItemResult(
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
        this.pictures,
        this.relatedAnime});

  SearchMalDetailApiItemResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    star = json['star'];
    popularity = json['popularity'];
    rank = json['rank'];
    synopsis = json['synopsis'];
    status = json['status'];
    genres = json['genres'];
    numEpisodes = json['num_episodes'];
    startSeason = json['start_season'];
    pictures = json['pictures'].cast<String>();
    if (json['related_anime'] != null) {
      relatedAnime = new List<SearchMalDetailRelatedAnimeItem>();
      json['related_anime'].forEach((v) {
        relatedAnime.add(new SearchMalDetailRelatedAnimeItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
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
    return data;
  }
}

class SearchMalDetailRelatedAnimeItem {
  int id;
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
