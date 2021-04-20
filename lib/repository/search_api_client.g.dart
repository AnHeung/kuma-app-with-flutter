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
  Future<SearchMalApiSearchItem> getSearchItems(query) async {
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
    final value = SearchMalApiSearchItem.fromJson(_result.data);
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
  Future<SearchMalDetailApiItem> getMalApiDetailItem(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/mal/detail/$id',
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
  Future<SearchMalApiGenreListItem> getGenreCategoryList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/mal/genreList',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchMalApiGenreListItem.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchMalApiCharacterPictureItem> getCharacterPictureList(
      characterId) async {
    ArgumentError.checkNotNull(characterId, 'characterId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/mal/character/pictures/$characterId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchMalApiCharacterPictureItem.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchMalCharacterDetailItem> getCharacterInfo(characterId) async {
    ArgumentError.checkNotNull(characterId, 'characterId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/mal/character/$characterId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchMalCharacterDetailItem.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchMalCharacterDetailItem> getPersonInfo(personId) async {
    ArgumentError.checkNotNull(personId, 'personId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/mal/person/$personId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchMalCharacterDetailItem.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchRankingApiResult> getRankingItemList(
      type, page, rankType, limit) async {
    ArgumentError.checkNotNull(type, 'type');
    ArgumentError.checkNotNull(page, 'page');
    ArgumentError.checkNotNull(rankType, 'rankType');
    ArgumentError.checkNotNull(limit, 'limit');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/mal/ranking/$type/$page/$rankType/$limit',
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

  @override
  Future<SearchMalAllGenreItem> getAllGenreItems(type, q, page, status, rated,
      genre, startDate, endDate, genreExclude, limit, sort) async {
    ArgumentError.checkNotNull(type, 'type');
    ArgumentError.checkNotNull(q, 'q');
    ArgumentError.checkNotNull(page, 'page');
    ArgumentError.checkNotNull(status, 'status');
    ArgumentError.checkNotNull(rated, 'rated');
    ArgumentError.checkNotNull(genre, 'genre');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(genreExclude, 'genreExclude');
    ArgumentError.checkNotNull(limit, 'limit');
    ArgumentError.checkNotNull(sort, 'sort');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'type': type,
      r'q': q,
      r'page': page,
      r'status': status,
      r'rated': rated,
      r'genre': genre,
      r'start_date': startDate,
      r'end_date': endDate,
      r'genre_exclude': genreExclude,
      r'limit': limit,
      r'sort': sort
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/mal/all',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchMalAllGenreItem.fromJson(_result.data);
    return value;
  }
}
