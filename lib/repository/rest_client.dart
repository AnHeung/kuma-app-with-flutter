
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://api.kumaserver.me/")
abstract class RestClient {

  // manatoki, crawling , down , siteInfo , hotdeal , torrent , schedule
  factory RestClient(Dio dio , {String baseUrl}) = _RestClient;

}