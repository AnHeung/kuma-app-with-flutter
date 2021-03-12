import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kuma_flutter_app/bloc/auth/auth_bloc.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/enums/login_status.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_detail_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_ranking_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_season_item.dart';
import 'package:kuma_flutter_app/model/api/social_user.dart';
import 'package:kuma_flutter_app/repository/firebase_client.dart';
import 'package:kuma_flutter_app/repository/rest_client.dart';
import 'package:kuma_flutter_app/repository/search_api_client.dart';

class ApiRepository {

  final RestClient restClient;

  final SearchApiClient searchApiClient;

  final FirebaseClient firebaseClient;

  ApiRepository({this.restClient, this.searchApiClient,this.firebaseClient});

  Future<SearchMalApiItem> getMalApiItem(String query) => searchApiClient.getSearchItems(query);

  Future<SearchMalApiItem> getSearchItems(String query) => searchApiClient.getSearchItems(query);

  Future<SearchMalApiSeasonItem> getSeasonItems (String limit) => searchApiClient.getSeasonItems(limit);

  Future<SearchMalDetailApiItem> getDetailApiItem(String id , String type) => searchApiClient.getMalApiDetailItem(id, type);

  Future<SearchRankingApiResult> getRankingItemList(
          String rankType, String limit, String searchType) =>
      searchApiClient.getRankingItemList(rankType, limit, searchType);

  register(String email, String pw)=> firebaseClient.register(email, pw);

  Future<Map<LoginStatus , SocialUserData>> login({SocialType type ,BuildContext context})=> firebaseClient.login(type: type, context: context);

  logout({SocialType type ,BuildContext context})=> firebaseClient.logOut(type: type, context: context);

  Stream<User> get user =>firebaseClient.user;

}
