class SearchMalApiCharacterItem {
  bool err;
  String msg;
  List<Result> result;

  SearchMalApiCharacterItem({this.err, this.msg, this.result});

  SearchMalApiCharacterItem.fromJson(Map<String, dynamic> json) {
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
  String characterId;
  String name;
  String role;
  String imageUrl;
  String url;

  Result({this.characterId, this.name, this.role, this.imageUrl, this.url});

  Result.fromJson(Map<String, dynamic> json) {
    characterId = json['character_id'];
    name = json['name'];
    role = json['role'];
    imageUrl = json['image_url'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['character_id'] = this.characterId;
    data['name'] = this.name;
    data['role'] = this.role;
    data['image_url'] = this.imageUrl;
    data['url'] = this.url;
    return data;
  }
}