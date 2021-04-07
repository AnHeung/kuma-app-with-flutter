class SearchMalApiScheduleItem {
  bool err;
  String msg;
  List<Result> result;

  SearchMalApiScheduleItem({this.err, this.msg, this.result});

  SearchMalApiScheduleItem.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    if (json['result'] != null) {
      result = new List<Result>();
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
  String score;
  String startDate;

  Result({this.id, this.title, this.image, this.score, this.startDate});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    score = json['score'];
    startDate = json['start_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['score'] = this.score;
    data['start_date'] = this.startDate;
    return data;
  }
}