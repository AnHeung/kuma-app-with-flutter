// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://api.kumaserver.me/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ApiAnimeNewsItem> getAnimeNewsItems(viewCount, page) async {
    ArgumentError.checkNotNull(viewCount, 'viewCount');
    ArgumentError.checkNotNull(page, 'page');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': viewCount,
      r'viewCount': page
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/animationNews',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ApiAnimeNewsItem.fromJson(_result.data);
    return value;
  }
}
