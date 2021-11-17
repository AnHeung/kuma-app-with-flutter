import 'package:flutter/cupertino.dart';

class AppEnvItem{

  String API_URL;
  String API_KEY;
  String API_KEY_VALUE;
  String SEARCH_API_URL;
  String KAKAO_CLIENT_ID;
  String KAKAO_JAVASCRIPT_CLIENT_ID;

  AppEnvItem({
    @required this.API_URL,
    @required this.API_KEY,
    @required this.API_KEY_VALUE,
    @required this.SEARCH_API_URL,
    @required this.KAKAO_CLIENT_ID,
    @required this.KAKAO_JAVASCRIPT_CLIENT_ID,
  });

  AppEnvItem copyWith({
    String API_URL,
    String API_KEY,
    String API_KEY_VALUE,
    String SEARCH_API_URL,
    String KAKAO_CLIENT_ID,
    String KAKAO_JAVASCRIPT_CLIENT_ID,
  }) {
    return new AppEnvItem(
      API_URL: API_URL ?? this.API_URL,
      API_KEY: API_KEY ?? this.API_KEY,
      API_KEY_VALUE: API_KEY_VALUE ?? this.API_KEY_VALUE,
      SEARCH_API_URL: SEARCH_API_URL ?? this.SEARCH_API_URL,
      KAKAO_CLIENT_ID: KAKAO_CLIENT_ID ?? this.KAKAO_CLIENT_ID,
      KAKAO_JAVASCRIPT_CLIENT_ID:
          KAKAO_JAVASCRIPT_CLIENT_ID ?? this.KAKAO_JAVASCRIPT_CLIENT_ID,
    );
  }

  @override
  String toString() {
    return 'AppEnvItem{API_URL: $API_URL, API_KEY: $API_KEY, API_KEY_VALUE: $API_KEY_VALUE, SEARCH_API_URL: $SEARCH_API_URL, KAKAO_CLIENT_ID: $KAKAO_CLIENT_ID, KAKAO_JAVASCRIPT_CLIENT_ID: $KAKAO_JAVASCRIPT_CLIENT_ID}';
  }

}