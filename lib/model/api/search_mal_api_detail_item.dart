import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SearchMalDetailApiItem {
  int id;
  String title;
  String image;
  String startDate;
  String endDate;
  double star;
  int popularity;
  int rank;
  String synopsis;
  String status;
  String genres;
  int numEpisodes;
  int startSeason;
  List<RelatedAnime> relatedAnime;

  SearchMalDetailApiItem(
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

  SearchMalDetailApiItem.fromJson(Map<String, dynamic> json) {
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
    if (json['related_anime'] != null) {
      relatedAnime = new List<RelatedAnime>();
      json['related_anime'].forEach((v) {
        relatedAnime.add(new RelatedAnime.fromJson(v));
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
    if (this.relatedAnime != null) {
      data['related_anime'] = this.relatedAnime.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@JsonSerializable()
class RelatedAnime {
  int id;
  String title;
  String image;

  RelatedAnime({this.id, this.title, this.image});

  RelatedAnime.fromJson(Map<String, dynamic> json) {
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
