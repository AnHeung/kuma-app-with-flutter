class SearchMalApiGenreListItem {
  bool err;
  String msg;
  List<Result> result;

  SearchMalApiGenreListItem({this.err, this.msg, this.result});

  SearchMalApiGenreListItem.fromJson(Map<String, dynamic> json) {
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
  String type;
  String typeKorea;
  List<GenreResult> genreResult;
  List<Result> result;

  Result({this.type, this.typeKorea, this.genreResult, this.result});

  Result.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    typeKorea = json['typeKorea'];
    if (json['genre_result'] != null) {
      genreResult = new List<GenreResult>();
      json['genre_result'].forEach((v) {
        genreResult.add(new GenreResult.fromJson(v));
      });
    }
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['typeKorea'] = this.typeKorea;
    if (this.genreResult != null) {
      data['genre_result'] = this.genreResult.map((v) => v.toJson()).toList();
    }
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GenreResult {
  String category;
  String categoryValue;

  GenreResult({this.category, this.categoryValue});

  GenreResult.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    categoryValue = json['categoryValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['categoryValue'] = this.categoryValue;
    return data;
  }
}