import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/enums/login_status.dart';
import 'package:kuma_flutter_app/enums/register_status.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_all_genre_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_character_picture_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_detail_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_genre_list_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_ranking_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_schedule_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_search_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_season_item.dart';
import 'package:kuma_flutter_app/model/api/social_user.dart';
import 'package:kuma_flutter_app/repository/firebase_client.dart';
import 'package:kuma_flutter_app/repository/rest_client.dart';
import 'package:kuma_flutter_app/repository/search_api_client.dart';

class ApiRepository {
  final RestClient restClient;

  final SearchApiClient searchApiClient;

  final FirebaseClient firebaseClient;

  ApiRepository({this.restClient, this.searchApiClient, this.firebaseClient});

  Future<SearchMalApiScheduleItem> getScheduleItems(String day) =>
      searchApiClient.getScheduleItems(day);

  Future<SearchMalApiSearchItem> getSearchItems(String query) =>
      searchApiClient.getSearchItems(query);

  Future<SearchMalApiSeasonItem> getSeasonItems(String limit) =>
      searchApiClient.getSeasonItems(limit);

  Future<SearchMalDetailApiItem> getDetailApiItem(String id) =>
      searchApiClient.getMalApiDetailItem(id);

  Future<SearchMalApiGenreListItem> getGenreCategoryList() => searchApiClient.getGenreCategoryList();

  Future<SearchMalApiCharacterPictureItem> getCharacterPictureList(String characterId) => searchApiClient.getCharacterPictureList(characterId);

  Future<SearchMalAllGenreItem> getAllGenreItems({
          String type,
          String q,
          String page,
          String status,
          String rated,
          String genre,
          String startDate,
          String endDate,
          String genreExclude,
          String limit,
          String sort}) => searchApiClient.getAllGenreItems(type, q, page, status, rated, genre,
          startDate, endDate, genreExclude, limit, sort);

  Future<SearchRankingApiResult> getRankingItemList(
      String type, String page, String rankType, String limit) =>
      searchApiClient.getRankingItemList(type,page, rankType, limit);

  Future<RegisterStatus> register({LoginUserData userData}) =>
      firebaseClient.register(userData: userData);

  Future<Map<LoginStatus, LoginUserData>> login(
          {LoginType type, BuildContext context}) =>
      firebaseClient.login(type: type, context: context);

  Future<Map<LoginStatus, LoginUserData>> firebaseSignIn(
          {LoginUserData userData}) =>
      firebaseClient.firebaseSignIn(userData: userData);

  logout() => firebaseClient.logout();

  Stream<User> get userStream => firebaseClient.userStream;

  User get user => firebaseClient.user;

  withdraw() => firebaseClient.withdraw();
}
