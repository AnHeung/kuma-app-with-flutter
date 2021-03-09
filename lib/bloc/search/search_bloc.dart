import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_item.dart';
import 'package:kuma_flutter_app/model/item/animation_search_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  final ApiRepository repository;

  SearchBloc({this.repository}) : super(InitialSearchScreen());

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
      Stream<SearchEvent> events,
      TransitionFunction<SearchEvent, SearchState> transitionFn) {

    final durationTime = 500;
    final nonDebounceStream = events.where((event){
      return event is! SearchQueryUpdate;
    });

    final debounceStream = events
        .where((event){
          return event is SearchQueryUpdate;
    })
        .debounceTime(Duration(milliseconds: durationTime));

    return MergeStream([nonDebounceStream,debounceStream])
        .switchMap(transitionFn);
  }

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchQueryUpdate) {
      yield* _mapToSearchUpdate(event);
    } else if (event is SearchLoad) {
      yield* _mapToSearchLoad(event);
    } else if (event is SearchClear) {
      yield* _mapToSearchClear();
    }else if(event is SearchBtnClick){
      yield* _mapToSearchBtnClick(event);
    }
  }


  Stream<SearchState> _mapToSearchBtnClick(SearchBtnClick event) async* {
    bool isClick = event.isClick;
    if(isClick) yield SetSearchScreen();
    else yield InitialSearchScreen();
  }

  Stream<SearchState> _mapToSearchUpdate(SearchQueryUpdate event) async* {

    String query = event.searchQuery;

    if(query.isEmpty){
      yield SetSearchScreen();
    } else{
      if(state is! SearchItemLoadSuccess){yield SearchLoadInProgress();}
      SearchMalApiItem searchItems = await repository.getSearchItems(query);
      if (searchItems.err) {
        yield SearchLoadFailure(errMsg: searchItems.msg);
      } else {
        yield SearchItemLoadSuccess(
            list: searchItems.result
                .map((result) => AnimationSearchItem(
                id: result.id, title: result.title, image: result.image))
                .toList());
      }
    }
  }

  Stream<SearchState> _mapToSearchClear() async* {
    yield InitialSearchScreen();
  }

  Stream<SearchState> _mapToSearchLoad(SearchLoad event) async* {
    yield SearchLoadInProgress();
    String query = event.searchQuery;
    SearchMalApiItem searchItems = await repository.getSearchItems(query);
    if (searchItems.err) {
      yield SearchLoadFailure(errMsg: searchItems.msg);
    } else {
      yield SearchItemLoadSuccess(
          list: searchItems.result
              .map((result) => AnimationSearchItem(
                  id: result.id, title: result.title, image: result.image))
              .toList());
    }
  }
}
