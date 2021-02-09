import 'package:json_annotation/json_annotation.dart';
part 'search_mal_api_ranking_item.g.dart';

@JsonSerializable()
class SearchRankingApiResult {
  bool err;
  String msg;
  List<SearchRankingApiItem> result;

  SearchRankingApiResult({this.err, this.msg, this.result});

  factory SearchRankingApiResult.fromJson(Map<String, dynamic> json) => _$SearchRankingApiResultFromJson(json);
  Map<String, dynamic> toJson() => _$SearchRankingApiResultToJson(this);

}

@JsonSerializable()
class SearchRankingApiItem {
  String type;
  List<SearchRankingData> rank_result;

  SearchRankingApiItem({this.type, this.rank_result});

  factory SearchRankingApiItem.fromJson(Map<String, dynamic> json) => _$SearchRankingApiItemFromJson(json);
  Map<String, dynamic> toJson() => _$SearchRankingApiItemToJson(this);

}

@JsonSerializable()
class SearchRankingData {
  int id;
  String title;
  String image;
  int ranking;

  SearchRankingData({this.id, this.title, this.image, this.ranking});

  factory SearchRankingData.fromJson(Map<String, dynamic> json) => _$SearchRankingDataFromJson(json);
  Map<String, dynamic> toJson() => _$SearchRankingDataToJson(this);
}


