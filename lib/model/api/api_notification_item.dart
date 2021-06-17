class ApiNotificationItem {
  bool err;
  String msg;
  List<Data> data;

  ApiNotificationItem({this.err, this.msg, this.data});

  ApiNotificationItem.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add( Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['err'] = this.err;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String title;
  String userId;
  int iV;
  String animationId;
  String createdAt;
  String date;
  String image;
  String mainTitle;
  String summary;
  String thumbnail;
  String updatedAt;
  String url;

  Data(
      {this.title,
        this.userId,
        this.iV,
        this.animationId,
        this.createdAt,
        this.date,
        this.image,
        this.mainTitle,
        this.summary,
        this.thumbnail,
        this.updatedAt,
        this.url});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    userId = json['userId'];
    iV = json['__v'];
    animationId = json['animationId'];
    createdAt = json['createdAt'];
    date = json['date'];
    image = json['image'];
    mainTitle = json['mainTitle'];
    summary = json['summary'];
    thumbnail = json['thumbnail'];
    updatedAt = json['updatedAt'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['title'] = this.title;
    data['userId'] = this.userId;
    data['__v'] = this.iV;
    data['animationId'] = this.animationId;
    data['createdAt'] = this.createdAt;
    data['date'] = this.date;
    data['image'] = this.image;
    data['mainTitle'] = this.mainTitle;
    data['summary'] = this.summary;
    data['thumbnail'] = this.thumbnail;
    data['updatedAt'] = this.updatedAt;
    data['url'] = this.url;
    return data;
  }
}