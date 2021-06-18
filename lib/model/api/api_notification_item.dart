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
        data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['err'] = this.err;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String title;
  String userId;
  String animationId;
  String date;
  bool isRead;
  String image;
  String mainTitle;
  String summary;
  String thumbnail;
  String url;

  Data({
      this.id,
      this.title,
      this.userId,
      this.animationId,
      this.date,
      this.isRead,
      this.image,
      this.mainTitle,
      this.summary,
      this.thumbnail,
      this.url});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    userId = json['userId'];
    animationId = json['animationId'];
    date = json['date'];
    isRead = json['isRead'];
    image = json['image'];
    mainTitle = json['mainTitle'];
    summary = json['summary'];
    thumbnail = json['thumbnail'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['userId'] = this.userId;
    data['animationId'] = this.animationId;
    data['date'] = this.date;
    data['isRead'] = this.isRead;
    data['image'] = this.image;
    data['mainTitle'] = this.mainTitle;
    data['summary'] = this.summary;
    data['thumbnail'] = this.thumbnail;
    data['url'] = this.url;
    return data;
  }
}
