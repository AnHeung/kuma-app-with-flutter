class SearchMalApiGenreItem {
  bool err;
  String msg;
  List<Result> result;

  SearchMalApiGenreItem({this.err, this.msg, this.result});

  SearchMalApiGenreItem.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['err'] = this.err;
    data['msg'] = this.msg;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int id;
  String title;
  String image;
  double score;
  int episodes;
  String startDate;
  List<Genres> genres;

  Result(
      {this.id,
        this.title,
        this.image,
        this.score,
        this.episodes,
        this.startDate,
        this.genres});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    score = json['score'];
    episodes = json['episodes'];
    startDate = json['start_date'];
    if (json['genres'] != null) {
      genres = [];
      json['genres'].forEach((v) {
        genres.add(new Genres.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['score'] = this.score;
    data['episodes'] = this.episodes;
    data['start_date'] = this.startDate;
    if (this.genres != null) {
      data['genres'] = this.genres.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Genres {
  int genreId;
  String genreName;

  Genres({this.genreId, this.genreName});

  Genres.fromJson(Map<String, dynamic> json) {
    genreId = json['genre_id'];
    genreName = json['genre_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['genre_id'] = this.genreId;
    data['genre_name'] = this.genreName;
    return data;
  }
}