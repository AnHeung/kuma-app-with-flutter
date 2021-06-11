import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/enums/login_status.dart';
import 'package:kuma_flutter_app/enums/register_status.dart';
import 'package:kuma_flutter_app/model/api/api_anime_news_item.dart';
import 'package:kuma_flutter_app/model/api/firebase_user_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_all_genre_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_character_picture_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_detail_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_genre_list_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_ranking_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_schedule_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_search_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_season_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_character_detail_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_person_item.dart';
import 'package:kuma_flutter_app/model/api/login_user.dart';
import 'package:kuma_flutter_app/model/item/subscribe_item.dart';
import 'package:kuma_flutter_app/repository/firebase_client.dart';
import 'package:kuma_flutter_app/repository/api_client.dart';
import 'package:kuma_flutter_app/repository/search_api_client.dart';

class ApiRepository {
  final ApiClient apiClient;

  final SearchApiClient searchApiClient;

  final FirebaseClient firebaseClient;

  ApiRepository({this.apiClient, this.searchApiClient, this.firebaseClient});

  Future<SearchMalApiScheduleItem> getScheduleItems(String day) =>
      searchApiClient.getScheduleItems(day);

  Future<SearchMalApiSearchItem> getSearchItems(String query) =>
      searchApiClient.getSearchItems(query);

  Future<SearchMalApiSeasonItem> getSeasonItems(String limit) =>
      searchApiClient.getSeasonItems(limit);

  Future<SearchMalDetailApiItem> getDetailApiItem(String id) =>
      searchApiClient.getMalApiDetailItem(id);

  Future<SearchMalApiGenreListItem> getGenreCategoryList() => searchApiClient.getGenreCategoryList();

  Future<SearchMalCharacterDetailItem> getCharacterInfo(String characterId) => searchApiClient.getCharacterInfo(characterId);

  Future<SearchMalPersonItem> getPersonInfo(String personId) => searchApiClient.getPersonInfo(personId);

  Future<SearchMalApiCharacterPictureItem> getCharacterPictureList(String characterId) => searchApiClient.getCharacterPictureList(characterId);

  Future<ApiAnimeNewsItem> getAnimationNewsItem(String page, String viewCount) => apiClient.getAnimeNewsItems(page , viewCount , "","");

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
          String sort ,String orderBy}) => searchApiClient.getAllGenreItems(type, q, page, status, rated, genre,
          startDate, endDate, genreExclude, limit, sort, orderBy);

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

  withdraw(String userId) => firebaseClient.withdraw(userId);

  updateUserItemToFireStore(String userId , Map<String,dynamic> userItem)=>firebaseClient.updateUserItemToFireStore(userId: userId, userItem: userItem);

  saveAllUserItemToFireStore(String userId , LoginUserData userData)=>firebaseClient.saveAllUserItemToFireStore(userData:userData);

  getUserItemFromFireStore({String userId})=>firebaseClient.getUserItemFromFireStore(userId: userId);

  isSubscribe({String userId , String animationId})=>firebaseClient.isSubscribe(userId: userId, animationId: animationId);

  updateSubscribeAnimation({String userId , SubscribeItem item ,bool isSubscribe})=>firebaseClient.updateSubscribeAnimation(userId: userId, item: item, isSubscribe:isSubscribe);

}
