class SearchMalApiSeasonItem {
  bool err;
  String msg;
  List<SearchMalApiSeasonItemResult> result;

  SearchMalApiSeasonItem({this.err, this.msg, this.result});

  SearchMalApiSeasonItem.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    if (json['result'] != null) {
      result = new List<SearchMalApiSeasonItemResult>();
      json['result'].forEach((v) {
        result.add(new SearchMalApiSeasonItemResult.fromJson(v));
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

class SearchMalApiSeasonItemResult {
  int id;
  String title;
  String image;

  SearchMalApiSeasonItemResult({this.id, this.title, this.image});

  SearchMalApiSeasonItemResult.fromJson(Map<String, dynamic> json) {
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
