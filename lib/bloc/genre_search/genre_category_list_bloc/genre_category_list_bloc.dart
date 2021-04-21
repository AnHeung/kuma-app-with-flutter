import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/enums/category_click_status.dart';
import 'package:kuma_flutter_app/enums/genre_title.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_genre_list_item.dart';
import 'package:kuma_flutter_app/model/genre_data.dart';
import 'package:kuma_flutter_app/model/item/genre_nav_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/string_util.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'genre_category_list_event.dart';
part 'genre_category_list_state.dart';

class GenreCategoryListBloc extends Bloc<GenreCategoryListEvent, GenreCategoryListState> {

  final ApiRepository repository;

  GenreCategoryListBloc({this.repository}) : super(const GenreCategoryListState(status: GenreCategoryStatus.initial));

  @override
  Stream<Transition<GenreCategoryListEvent, GenreCategoryListState>> transformEvents(
      Stream<GenreCategoryListEvent> events,
      TransitionFunction<GenreCategoryListEvent, GenreCategoryListState> transitionFn) {

    const durationTime = 300;
    final nonDebounceStream = events.where((event){
      return event is! GenreItemClick && event is! GenreItemRemove;
    });

    final debounceStream = events
        .where((event)=>event is GenreItemClick || event is GenreItemRemove)
        .debounceTime(const Duration(milliseconds: durationTime));

    return MergeStream([nonDebounceStream,debounceStream])
        .switchMap(transitionFn);
  }

  @override
  Stream<GenreCategoryListState> mapEventToState(
    GenreCategoryListEvent event,
  ) async* {
   if (event is GenreCategoryListLoad) {
    yield* _mapToGenreCategoryListLoad(state);
    }else if(event is GenreItemClick){
    yield* _mapToGenreItemClick(event ,state);
    }else if(event is GenreItemRemove){
    yield* _mapToGenreItemRemove(event,state);
    }else if(event is GenreItemRemoveAll){
     yield* _mapToGenreRemoveAll(state); 
   }
  }

  Stream<GenreCategoryListState> _mapToGenreCategoryListLoad(GenreCategoryListState state) async* {
    yield const GenreCategoryListState(status: GenreCategoryStatus.loading);
    SearchMalApiGenreListItem searchMalApiGenreListItem = await repository.getGenreCategoryList();
    if (searchMalApiGenreListItem.err) {
      yield GenreCategoryListState(status: GenreCategoryStatus.loading , msg: searchMalApiGenreListItem.msg);
    } else {
      yield GenreCategoryListState(
          status: GenreCategoryStatus.success,
          genreListItems: searchMalApiGenreListItem.result
              .map((resultItem) => GenreListItem(
              koreaType: resultItem.typeKorea,
              type: resultItem.type,
              navItems: resultItem.genreResult.map((result) => GenreNavItem(
                  category: result.category,
                  categoryValue: result.categoryValue,
                  clickStatus: CategoryClickStatus.NONE,
                  genreType:  enumFromString<GenreType>(resultItem.type, GenreType.values))).toList())).toList() , genreData: GenreData(page: "1"));
    }
  }

  Stream<GenreCategoryListState> _mapToGenreRemoveAll(GenreCategoryListState state)async*{
    yield GenreCategoryListState(status: GenreCategoryStatus.success, genreListItems: state.genreListItems.map((item) => item.copyWith(navItems: item.navItems.map((navItem) => navItem.copyWith(clickStatus: CategoryClickStatus.NONE)).toList())).toList() , genreData: GenreData());
  }


  Stream<GenreCategoryListState> _mapToGenreItemClick(GenreItemClick event , GenreCategoryListState state)async*{
    GenreNavItem clickItem = event.navItem.copyWith(clickStatus: _changeCategoryStatus(event.navItem.clickStatus, event.navItem.genreType));
    List<GenreListItem> genreListItems = _getUpdateItem(state.genreListItems , clickItem);
    GenreData genreData = _getGenreData(genreListItems:genreListItems);
    yield GenreCategoryListState(status: GenreCategoryStatus.success, genreListItems:genreListItems ,genreData: genreData.copyWith(page: "1"));
  }

  Stream<GenreCategoryListState> _mapToGenreItemRemove(GenreItemRemove event , GenreCategoryListState state)async*{
    GenreNavItem clickItem = event.navItem.copyWith(clickStatus: CategoryClickStatus.NONE);
    List<GenreListItem> genreListItems= _getUpdateItem(state.genreListItems , clickItem);
    GenreData genreData = _getGenreData(genreListItems:genreListItems);
    yield GenreCategoryListState(status: GenreCategoryStatus.success, genreListItems:genreListItems , genreData:genreData.copyWith(page: "1"));
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
        if(navItem.genreType != GenreType.GENRE && navItem.genreType != GenreType.RATED && navItem.genreType == updateItem.genreType){
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
  
  _removeItem({String baseString , String removeItem}){
    return baseString.split(",").remove(removeItem);
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
