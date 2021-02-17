import 'package:kuma_flutter_app/model/api/search_mal_api_detail_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_ranking_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_simple_item.dart';
import 'package:kuma_flutter_app/repository/rest_client.dart';
import 'package:kuma_flutter_app/repository/search_api_client.dart';

class ApiRepository {
  final RestClient restClient;

  final SearchApiClient searchApiClient;

  ApiRepository({this.restClient, this.searchApiClient});

  Future<SearchMalApiItem> getMalApiItem(String query) => searchApiClient.getTranslateTitleList(query);

  Future<SearchMalDetailApiItem> getDetailApiItem(String id , String type) => searchApiClient.getMalApiDetailItem(id, type);

  Future<SearchRankingApiResult> getRankingItemList(
          String rankType, String limit, String searchType) =>
      searchApiClient.getRankingItemList(rankType, limit, searchType);
}
