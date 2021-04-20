class SearchMalApiCharacterPictureItem {
  bool err;
  String msg;
  List<SearchMalApiCharacterPictureResult> result;

  SearchMalApiCharacterPictureItem({this.err, this.msg, this.result});

  SearchMalApiCharacterPictureItem.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result.add(new SearchMalApiCharacterPictureResult.fromJson(v));
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

class SearchMalApiCharacterPictureResult {
  String image;

  SearchMalApiCharacterPictureResult({this.image});

  SearchMalApiCharacterPictureResult.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}
