class ApiAnimeNewsItem {
  bool err;
  String msg;
  List<AnimeNewsItemResult> data;

  ApiAnimeNewsItem({this.err, this.msg, this.data});

  ApiAnimeNewsItem.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new AnimeNewsItemResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['err'] = this.err;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnimeNewsItemResult {
  String date;
  String url;
  int iV;
  String createdAt;
  String image;
  String summary;
  String title;
  String updatedAt;

  AnimeNewsItemResult(
      {this.date,
        this.url,
        this.iV,
        this.createdAt,
        this.image,
        this.summary,
        this.title,
        this.updatedAt});

  AnimeNewsItemResult.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    url = json['url'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    image = json['image'];
    summary = json['summary'];
    title = json['title'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['url'] = this.url;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['image'] = this.image;
    data['summary'] = this.summary;
    data['title'] = this.title;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}