
import 'package:dio/dio.dart';
import 'package:kuma_flutter_app/model/api/api_anime_news_item.dart';
import 'package:kuma_flutter_app/model/api/api_notification_item.dart';
import 'package:kuma_flutter_app/model/api/api_simple_item.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {

  @GET("/animationNews")
  Future<ApiAnimeNewsItem> getAnimeNewsItems(@Query("page") String viewCount, @Query("viewCount")String page ,  @Query("startDate")String startDate,  @Query("endDate")String endDate);

  @GET("/notification")
  Future<ApiNotificationItem> getNotificationItems({@Query("userId") String userId, @Query("startDate")String startDate});

  @POST("/notification/read")
  Future<ApiSimpleItem> updateIsRead({@Body() Map<String, dynamic> params});


  factory ApiClient(Dio dio , {String baseUrl}) = _ApiClient;


}