import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/enums/category_click_status.dart';
import 'package:kuma_flutter_app/enums/genre_title.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_genre_list_item.dart';
import 'package:kuma_flutter_app/model/item/genre_data.dart';
import 'package:kuma_flutter_app/model/item/genre_nav_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/common.dart';
import 'package:meta/meta.dart';

part 'genre_category_list_event.dart';
part 'genre_category_list_state.dart';

class GenreCategoryListBloc extends Bloc<GenreCategoryListEvent, GenreCategoryListState> {

  final ApiRepository repository;

  GenreCategoryListBloc({this.repository}) : super(const GenreCategoryListState().initialGenreCategoryState());


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
   }else if(event is GenreClickFromDetailScreen){
     yield* _mapToGenreClickFromDetailScreen(event,state);
   }
  }

  Stream<GenreCategoryListState> _mapToGenreCategoryListLoad(GenreCategoryListState state) async* {
    try {
      yield const GenreCategoryListState(status: GenreCategoryStatus.Loading);
      SearchMalApiGenreListItem searchMalApiGenreListItem = await repository.getGenreCategoryList();
      if (searchMalApiGenreListItem.err) {
            yield GenreCategoryListState(status: GenreCategoryStatus.Failure , msg: searchMalApiGenreListItem.msg);
          } else {
            yield GenreCategoryListState(
                status: GenreCategoryStatus.Success,
                genreListItems: searchMalApiGenreListItem.result
                    .map((resultItem) => GenreListItem(
                    koreaType: resultItem.typeKorea,
                    type: resultItem.type,
                    navItems: resultItem.genreResult.map((result) => GenreNavItem(
                        category: result.category,
                        categoryValue: result.categoryValue,
                        clickStatus: CategoryClickStatus.None,
                        genreType:  enumFromString<GenreType>(resultItem.type, GenreType.values))).toList())).toList() , genreData: GenreData(page: "1"));
          }
    } catch (e) {
      print("_mapToGenreCategoryListLoad : ${e}");
      yield GenreCategoryListState(status: GenreCategoryStatus.Failure , msg: "_mapToGenreCategoryListLoad : ${e}");
    }
  }

  Stream<GenreCategoryListState> _mapToGenreRemoveAll(GenreCategoryListState state)async*{
    yield GenreCategoryListState(status: GenreCategoryStatus.Success, genreListItems: state.genreListItems.map((item) => item.copyWith(navItems: item.navItems.map((navItem) => navItem.copyWith(clickStatus: CategoryClickStatus.None)).toList())).toList() , genreData: GenreData());
  }


  Stream<GenreCategoryListState> _mapToGenreItemClick(GenreItemClick event , GenreCategoryListState state) async*{
    GenreNavItem clickItem = event.navItem.copyWith(clickStatus: _changeCategoryStatus(event.navItem.clickStatus, event.navItem.genreType));
    yield* _genreCategorySuccessState(clickItem:clickItem , genreItemList: state.genreListItems);
  }

  Stream<GenreCategoryListState> _mapToGenreClickFromDetailScreen(GenreClickFromDetailScreen event , GenreCategoryListState state) async*{
    GenreNavItem clickItem = event.navItem.copyWith(clickStatus: _changeCategoryStatus(event.navItem.clickStatus, event.navItem.genreType));
    List<GenreListItem> genreListItems = _getClearItemList(state.genreListItems);
    yield* _genreCategorySuccessState(clickItem:clickItem , genreItemList: genreListItems);
  }

  Stream<GenreCategoryListState> _mapToGenreItemRemove(GenreItemRemove event , GenreCategoryListState state)async*{
    GenreNavItem clickItem = event.navItem.copyWith(clickStatus: CategoryClickStatus.None);
    yield* _genreCategorySuccessState(clickItem:clickItem , genreItemList: state.genreListItems);
  }

  Stream<GenreCategoryListState> _genreCategorySuccessState({GenreNavItem clickItem , List<GenreListItem> genreItemList}) async*{
    List<GenreListItem> updateGenreList= _getUpdateItemList(genreItemList , clickItem);
    GenreData genreData = _getGenreData(genreListItems:updateGenreList);
    yield GenreCategoryListState(status: GenreCategoryStatus.Success, genreListItems:updateGenreList , genreData:genreData.copyWith(page: "1"));
  }

  _getGenreData({List<GenreListItem> genreListItems}) {
    List<GenreNavItem> clickNavItem = _setClickItemList(genreListItems: genreListItems);

    return clickNavItem.fold(GenreData(), (acc, navItem) {
      GenreData genreData = (acc as GenreData);
      switch(navItem.genreType){
        case GenreType.Genre:
          if (navItem.clickStatus == CategoryClickStatus.Exclude) {
            String genreExclude = genreData.genreExclude ?? "";
            genreExclude = _appendComma(baseString: genreExclude, appendString: navItem.categoryValue);
            return genreData.copyWith(genreExclude: genreExclude);
          } else if (navItem.clickStatus == CategoryClickStatus.Include) {
            String genre = genreData.genre ?? "";
            genre = _appendComma(baseString: genre, appendString: navItem.categoryValue);
            return (acc as GenreData).copyWith(genre: genre);
          }
          return acc;
        case GenreType.Year:
          List<String> dateList = navItem.categoryValue.split("~");
          return genreData.copyWith(startDate: dateList.first , endDate: dateList.last);
        case GenreType.Airing:
          return genreData.copyWith(status: navItem.categoryValue);
        case GenreType.Rated:
          String rated = genreData.rated;
          rated = _appendComma(baseString: rated, appendString: navItem.categoryValue);
          return genreData.copyWith(rated: rated);
      }
    });
  }

  List<GenreNavItem> _setClickItemList({List<GenreListItem> genreListItems}){
    return genreListItems.fold([], (acc, genreItem) {
      genreItem.navItems
          .where((navItem) => navItem.clickStatus != CategoryClickStatus.None)
          .forEach((item) => acc.add(item));
      return acc;
    });
  }

  _getUpdateItemList(List<GenreListItem> genreListItems , GenreNavItem updateItem){
    return genreListItems.map((genreItem){
      return GenreListItem(type: genreItem.type , koreaType: genreItem.koreaType, navItems: genreItem.navItems.map((navItem){
        if(navItem.genreType != GenreType.Genre && navItem.genreType != GenreType.Rated && navItem.genreType == updateItem.genreType){
            if(navItem.categoryValue == updateItem.categoryValue) return navItem.copyWith(clickStatus: updateItem.clickStatus);
            else return navItem.copyWith(clickStatus: CategoryClickStatus.None);
        }
        if(navItem.categoryValue == updateItem.categoryValue) return navItem.copyWith(clickStatus: updateItem.clickStatus);
        return navItem;
      }).toList());
    }).toList();
  }

  _getClearItemList(List<GenreListItem> genreListItems){
    return genreListItems.map((genreItem){
      return genreItem.copyWith(navItems: genreItem.navItems.map((navItem){
        return  navItem.copyWith(clickStatus: CategoryClickStatus.None);
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
      case CategoryClickStatus.Include:
        if (genreType == GenreType.Genre) {
          clickStatus =  CategoryClickStatus.Exclude;
        } else {
          clickStatus =  CategoryClickStatus.None;
        }
        break;
      case CategoryClickStatus.Exclude:
        clickStatus =  CategoryClickStatus.None;
        break;
      case CategoryClickStatus.None:
        clickStatus =  CategoryClickStatus.Include;
        break;
    }
    return clickStatus;
  }
}
