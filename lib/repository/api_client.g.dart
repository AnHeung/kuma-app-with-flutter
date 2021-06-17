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
  Future<ApiAnimeNewsItem> getAnimeNewsItems(
      viewCount, page, startDate, endDate) async {
    ArgumentError.checkNotNull(viewCount, 'viewCount');
    ArgumentError.checkNotNull(page, 'page');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': viewCount,
      r'viewCount': page,
      r'startDate': startDate,
      r'endDate': endDate
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

  @override
  Future<ApiNotificationItem> getNotificationItems({userId, startDate}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'userId': userId,
      r'startDate': startDate
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/notification',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ApiNotificationItem.fromJson(_result.data);
    return value;
  }
}
