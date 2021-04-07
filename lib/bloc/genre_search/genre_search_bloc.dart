import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/enums/category_click_status.dart';
import 'package:kuma_flutter_app/enums/genre_title.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_all_genre_item.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_genre_list_item.dart';
import 'package:kuma_flutter_app/model/genre_data.dart';
import 'package:kuma_flutter_app/model/item/animation_genre_search_item.dart';
import 'package:kuma_flutter_app/model/item/genre_nav_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/string_util.dart';
import 'package:meta/meta.dart';

part 'genre_search_event.dart';
part 'genre_search_state.dart';

class GenreSearchBloc extends Bloc<GenreSearchEvent, GenreSearchState> {
  final ApiRepository repository;

  GenreSearchBloc({this.repository}) : super(GenreSearchInitial());

  @override
  Stream<GenreSearchState> mapEventToState(
    GenreSearchEvent event,
  ) async* {
    if (event is GenreLoad) {
      yield* _mapToGenreLoad(event);
    } else if (event is GenreCategoryListLoad) {
      yield* _mapToGenreCategoryListLoad();
    }else if(event is GenreItemClick){
      yield* _mapToGenreItemClick(event);
    }else if(event is GenreItemRemove){
      yield* _mapToGenreItemRemove(event);
    }
  }

  Stream<GenreSearchState> _mapToGenreCategoryListLoad() async* {
    SearchMalApiGenreListItem searchMalApiGenreListItem = await repository.getGenreCategoryList();
    if (searchMalApiGenreListItem.err) {
      yield GenreListLoadFailure(errMSg: searchMalApiGenreListItem.msg);
    } else {
      yield GenreListLoadSuccess(
          genreListItems: searchMalApiGenreListItem.result
              .map((resultItem) => GenreListItem(
                  koreaType: resultItem.typeKorea,
                  type: resultItem.type,
                  navItems: resultItem.genreResult.map((result) => GenreNavItem(
                      category: result.category,
                      categoryValue: result.categoryValue,
                      clickStatus: CategoryClickStatus.NONE,
                      genreType:  enumFromString<GenreType>(resultItem.type, GenreType.values))).toList())).toList());
    }
  }

  Stream<GenreSearchState> _mapToGenreLoad(GenreLoad event) async* {
    yield GenreSearchLoadInProgress();
    String q = event.data.q;
    String page = event.data.page;
    String type = event.data.type;
    String startDate = event.data.startDate;
    String endDate = event.data.endDate;
    String status = event.data.status;
    String limit = event.data.limit;
    String rated = event.data.rated;
    String genre = event.data.genre;
    String genreExclude = event.data.genreExclude;
    String sort = event.data.sort;

    SearchMalAllGenreItem genreItem = await repository.getAllGenreItems(
        type:type,
        q:q,
        page:page,
        status:status,
        rated:rated,
        genre:genre,
        startDate:startDate,
        endDate:endDate,
        genreExclude:genreExclude,
        limit:limit,
        sort:sort);

    if (genreItem.err) {
      yield GenreSearchLoadFailure(errMSg: genreItem.msg);
    } else {
      yield GenreSearchLoadSuccess(
          genreSearchItems: genreItem.result
              .map((item) => AnimationGenreSearchItem(
                  id: item.id,
                  title: item.title,
                  image: item.image,
                  score: item.score,
                  startDate: item.startDate,
                  endDate: item.endDate,
                  type: item.type,
                  airing: item.airing,
                  episodes: item.episodes,
                  rated: item.rated))
              .toList(),
          genreData: event.data);
    }
  }

  Stream<GenreSearchState> _mapToGenreItemClick(GenreItemClick event)async*{

    GenreNavItem clickItem = event.navItem.copyWith(clickStatus: _changeCategoryStatus(event.navItem.clickStatus, event.navItem.genreType));
    List<GenreListItem> genreListItems = _getUpdateItem( event.genreListItems , clickItem);
    GenreData genreData = _getGenreData(genreListItems:genreListItems);
    yield*_mapToGenreLoad(GenreLoad(data:genreData));
    yield GenreListLoadSuccess(genreListItems:genreListItems);
  }

  Stream<GenreSearchState> _mapToGenreItemRemove(GenreItemRemove event)async*{

    GenreNavItem clickItem = event.navItem.copyWith(clickStatus: CategoryClickStatus.NONE);
    List<GenreListItem> genreListItems= _getUpdateItem( event.genreListItems , clickItem);
    GenreData genreData = _getGenreData(genreListItems:genreListItems);
    yield*_mapToGenreLoad(GenreLoad(data:genreData));
    yield GenreListLoadSuccess(genreListItems:genreListItems);
  }

  _getGenreData({List<GenreListItem> genreListItems}) {

    List<GenreNavItem> clickNavItem = genreListItems.fold([], (acc, genreItem) {
      genreItem.navItems
          .where((navItem) => navItem.clickStatus != CategoryClickStatus.NONE)
          .forEach((item) => acc.add(item));
      return acc;
    });

    return clickNavItem.fold(GenreData(), (acc, navItem) {

      GenreData genreData = (acc as GenreData);

      switch(navItem.genreType){
        case GenreType.GENRE:
          if (navItem.clickStatus == CategoryClickStatus.EXCLUDE) {
            String genreExclude = genreData.genreExclude ?? "";
            genreExclude = _appendComma(baseString: genreExclude, appendString: navItem.categoryValue);
            return genreData.copyWith(genreExclude: genreExclude);
          } else if (navItem.clickStatus == CategoryClickStatus.INCLUDE) {
            String genre = genreData.genre ?? "";
            genre = _appendComma(baseString: genre, appendString: navItem.categoryValue);
            return (acc as GenreData).copyWith(genre: genre);
          }
          return acc;
        case GenreType.YEAR:
          List<String> dateList = navItem.categoryValue.split("~");
          return genreData.copyWith(startDate: dateList.first , endDate: dateList.last);
        case GenreType.AIRING:
          return genreData.copyWith(status: navItem.categoryValue);
        case GenreType.RATED:
          String rated = genreData.rated;
          rated = _appendComma(baseString: rated, appendString: navItem.categoryValue);
          return genreData.copyWith(rated: rated);
      }
    });
  }

  _getUpdateItem(List<GenreListItem> genreListItems , GenreNavItem updateItem){
    return genreListItems.map((genreItem){
      return GenreListItem(type: genreItem.type , koreaType: genreItem.koreaType, navItems: genreItem.navItems.map((navItem){
        if(navItem.genreType != GenreType.GENRE && navItem.genreType != GenreType.RATED){
          if(navItem.category == updateItem.category) return navItem.copyWith(clickStatus: updateItem.clickStatus);
          else return navItem.copyWith(clickStatus: CategoryClickStatus.NONE);
        }
        if(navItem.category == updateItem.category) return navItem.copyWith(clickStatus: updateItem.clickStatus);
        return navItem;
      }).toList());
    }).toList();
  }

  _appendComma({String baseString, String appendString}) {
    if (baseString.isEmpty)
      baseString = appendString;
    else
      baseString += ",$appendString";
    return baseString;
  }

  _changeCategoryStatus(CategoryClickStatus status , GenreType genreType) {

    CategoryClickStatus clickStatus = status;

    switch (status) {
      case CategoryClickStatus.INCLUDE:
        if (genreType == GenreType.GENRE) {
          clickStatus =  CategoryClickStatus.EXCLUDE;
        } else {
          clickStatus =  CategoryClickStatus.NONE;
        }
        break;
      case CategoryClickStatus.EXCLUDE:
        clickStatus =  CategoryClickStatus.NONE;
        break;
      case CategoryClickStatus.NONE:
        clickStatus =  CategoryClickStatus.INCLUDE;
        break;
    }
    return clickStatus;
  }
}
