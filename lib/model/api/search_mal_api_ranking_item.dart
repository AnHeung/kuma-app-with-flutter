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
  String koreaType;
  List<SearchRankingData> rank_result;

  SearchRankingApiItem({this.type, this.rank_result});

  factory SearchRankingApiItem.fromJson(Map<String, dynamic> json) => _$SearchRankingApiItemFromJson(json);
  Map<String, dynamic> toJson() => _$SearchRankingApiItemToJson(this);

}

@JsonSerializable()
class SearchRankingData {
  String id;
  String title;
  String image;
  String ranking;
  String score;

  SearchRankingData({this.id, this.title, this.image, this.ranking,this.score});

  factory SearchRankingData.fromJson(Map<String, dynamic> json) => _$SearchRankingDataFromJson(json);
  Map<String, dynamic> toJson() => _$SearchRankingDataToJson(this);
}


