import 'package:dio/dio.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_detail_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_ranking_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_season_item.dart';
import 'package:retrofit/http.dart';

part 'search_api_client.g.dart';

@RestApi(baseUrl: "https://search.kumaserver.me/")
abstract class SearchApiClient {
  // manatoki, crawling , down , siteInfo , hotdeal , torrent , schedule

  @GET("/translate/title")
  Future<SearchMalApiItem> getSearchItems(@Query("q") String query);

  @GET("/mal/season")
  Future<SearchMalApiSeasonItem> getSeasonItems(@Query("limit") String limit);

  @GET("/mal/detail")
  Future<SearchMalDetailApiItem> getMalApiDetailItem(@Query("id") String id , @Query("type")String type);

  @GET("/mal/ranking")
  Future<SearchRankingApiResult> getRankingItemList(
      @Query("ranking_type") String rankType,
      @Query("limit") String limit);

  factory SearchApiClient(Dio dio, {String baseUrl}) = _SearchApiClient;
}
