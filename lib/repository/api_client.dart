
import 'package:dio/dio.dart';
import 'package:kuma_flutter_app/model/api/api_anime_news_item.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://api.kumaserver.me/")
abstract class ApiClient {

  @GET("/animationNews")
  Future<ApiAnimeNewsItem> getAnimeNewsItems(@Query("page") String viewCount, @Query("viewCount")String page);

  factory ApiClient(Dio dio , {String baseUrl}) = _ApiClient;

}