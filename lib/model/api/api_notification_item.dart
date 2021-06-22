class ApiNotificationItem {
  bool err;
  String msg;
  Data data;

  ApiNotificationItem({this.err, this.msg, this.data});

  ApiNotificationItem.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['err'] = this.err;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<Result> result;
  String unReadCount;

  Data({this.result, this.unReadCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
    unReadCount = json['unReadCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    data['unReadCount'] = this.unReadCount;
    return data;
  }
}

class Result {
  String id;
  String title;
  String userId;
  String animationId;
  String date;
  String image;
  bool isRead;
  String mainTitle;
  String summary;
  String thumbnail;
  String url;

  Result(
      {this.id,
        this.title,
        this.userId,
        this.animationId,
        this.date,
        this.image,
        this.isRead,
        this.mainTitle,
        this.summary,
        this.thumbnail,
        this.url});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    userId = json['userId'];
    animationId = json['animationId'];
    date = json['date'];
    image = json['image'];
    isRead = json['isRead'];
    mainTitle = json['mainTitle'];
    summary = json['summary'];
    thumbnail = json['thumbnail'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['userId'] = this.userId;
    data['animationId'] = this.animationId;
    data['date'] = this.date;
    data['image'] = this.image;
    data['isRead'] = this.isRead;
    data['mainTitle'] = this.mainTitle;
    data['summary'] = this.summary;
    data['thumbnail'] = this.thumbnail;
    data['url'] = this.url;
    return data;
  }
}