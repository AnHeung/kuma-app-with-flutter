import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_item.dart';
import 'package:kuma_flutter_app/model/item/animation_search_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  ApiRepository repository;

  SearchBloc({this.repository}): super(SearchInit());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    yield SearchLoadInProgress();
    if(event is SearchUpdate){
      yield* _mapToSearchUpdate(event);
    }else if(event is SearchLoad){
      yield* _mapToSearchLoad(event);
    }else if(event is SearchClear){
      _mapToSearchClear();
    }
  }

  Stream<SearchState> _mapToSearchInit(SearchInit event) async* {
    yield SearchLoadSuccess();
  }

  Stream<SearchState> _mapToSearchUpdate(SearchUpdate event) async*{

  }

  Stream<SearchState> _mapToSearchClear() async* {
    yield SearchItemLoadSuccess();
  }

  Stream<SearchState> _mapToSearchLoad(SearchLoad event) async*{
    String query = event.searchQuery;
    SearchMalApiItem searchItems =  await repository.getSearchItems(query);
    if(searchItems.err){
      yield SearchLoadFailure(errMsg: searchItems.msg);
    }
    else{
      yield SearchItemLoadSuccess(list: searchItems.result.map((result) => AnimationSearchItem(id: result.id, title: result.title , image: result.image)).toList());
    }
  }

}
