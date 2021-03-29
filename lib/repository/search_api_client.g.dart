// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _SearchApiClient implements SearchApiClient {
  _SearchApiClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://search.kumaserver.me/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<SearchMalApiItem> getSearchItems(query) async {
    ArgumentError.checkNotNull(query, 'query');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'q': query};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/translate/title',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchMalApiItem.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchMalApiSeasonItem> getSeasonItems(limit) async {
    ArgumentError.checkNotNull(limit, 'limit');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'limit': limit};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/mal/season',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchMalApiSeasonItem.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchMalDetailApiItem> getMalApiDetailItem(id, type) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(type, 'type');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': id, r'type': type};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/mal/detail',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchMalDetailApiItem.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchRankingApiResult> getRankingItemList(rankType, limit) async {
    ArgumentError.checkNotNull(rankType, 'rankType');
    ArgumentError.checkNotNull(limit, 'limit');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'ranking_type': rankType,
      r'limit': limit
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/mal/ranking',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchRankingApiResult.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchMalApiScheduleItem> getScheduleItems(day) async {
    ArgumentError.checkNotNull(day, 'day');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/mal/schedule/$day',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchMalApiScheduleItem.fromJson(_result.data);
    return value;
  }
}
