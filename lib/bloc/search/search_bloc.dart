import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_search_item.dart';
import 'package:kuma_flutter_app/model/item/animation_search_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  final ApiRepository repository;

  SearchBloc({this.repository})
      : super(SearchState(status: SearchStatus.Initial));

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
      Stream<SearchEvent> events,
      TransitionFunction<SearchEvent, SearchState> transitionFn) {
    const  durationTime = 500;
    final nonDebounceStream = events.where((event) {
      return event is! SearchQueryUpdate;
    });

    final debounceStream = events
        .where((event) {
      return event is SearchQueryUpdate;
    })
        .debounceTime(const Duration(milliseconds: durationTime));

    return MergeStream([nonDebounceStream, debounceStream])
        .switchMap(transitionFn);
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event,) async* {
    if (event is SearchQueryUpdate) {
      yield* _mapToSearchUpdate(event, state);
    } else if (event is SearchLoad) {
      yield* _mapToSearchLoad(event);
    } else if (event is SearchClear) {
      yield* _mapToSearchClear();
    } else if (event is SearchBtnClick) {
      yield* _mapToSearchBtnClick(event);
    }
  }


  Stream<SearchState> _mapToSearchBtnClick(SearchBtnClick event) async* {
    bool isClick = event.isClick;
    if (isClick)
      yield SearchState(status: SearchStatus.Set);
    else
      yield SearchState(status: SearchStatus.Initial);
  }

  Stream<SearchState> _mapToSearchUpdate(SearchQueryUpdate event,
      SearchState state) async* {
    try {
      String query = event.searchQuery;

      if (query.isEmpty) {
        yield SearchState(status: SearchStatus.Clear);
      } else {
        yield SearchState(status: SearchStatus.Loading, list: state.list);
        SearchMalApiSearchItem searchItems = await repository.getSearchItems(query);
        if (searchItems.err) {
          yield SearchState(status: SearchStatus.Failure, msg: searchItems.msg ?? "검색 에러");
        } else {
          yield SearchState(
              status: SearchStatus.Success,
              list: searchItems.result
                  .map((result) =>
                  AnimationSearchItem(
                      id: result.id, title: result.title, image: result.image))
                  .toList());
        }
      }
    } catch (e) {
      yield SearchState(status: SearchStatus.Failure, msg: "검색 에러 $e");
    }
  }

  Stream<SearchState> _mapToSearchClear() async* {
    yield SearchState(status: SearchStatus.Success , list: [],);
  }

  Stream<SearchState> _mapToSearchLoad(SearchLoad event) async* {
    try {
      yield SearchState(status: SearchStatus.Loading);
      String query = event.searchQuery;
      SearchMalApiSearchItem searchItems = await repository.getSearchItems(query);
      if (searchItems.err) {
        yield SearchState(status: SearchStatus.Failure, msg: searchItems.msg);
      } else {
        yield SearchState(
            status: SearchStatus.Success,
            list: searchItems.result
                .map((result) =>
                AnimationSearchItem(
                    id: result.id, title: result.title, image: result.image))
                .toList());
      }
    } catch (e) {
      yield SearchState(status: SearchStatus.Failure, msg: "검색결과 불러오기 실패 :$e");
    }
  }

}