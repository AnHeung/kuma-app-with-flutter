class SearchMalAllGenreItem {
  bool err;
  String msg;
  List<Result> result;

  SearchMalAllGenreItem({this.err, this.msg, this.result});

  SearchMalAllGenreItem.fromJson(Map<String, dynamic> json) {
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
  String id;
  String title;
  String image;
  bool airing;
  String startDate;
  String endDate;
  String rated;
  String score;
  String type;
  String episodes;

  Result(
      {this.id,
        this.title,
        this.image,
        this.airing,
        this.startDate,
        this.endDate,
        this.rated,
        this.score,
        this.type,
        this.episodes});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    airing = json['airing'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    rated = json['rated'];
    score = json['score'];
    type = json['type'];
    episodes = json['episodes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['airing'] = this.airing;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['rated'] = this.rated;
    data['score'] = this.score;
    data['type'] = this.type;
    data['episodes'] = this.episodes;
    return data;
  }
}