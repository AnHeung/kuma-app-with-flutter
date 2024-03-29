import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/bloc/genre_search/category_list/genre_category_list_bloc.dart';
import 'package:kuma_flutter_app/enums/base_bloc_state_status.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_all_genre_item.dart';
import 'package:kuma_flutter_app/model/item/animation_genre_search_item.dart';
import 'package:kuma_flutter_app/model/item/genre_data.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part '../search/genre_search_event.dart';
part '../search/genre_search_state.dart';

class GenreSearchBloc extends Bloc<GenreSearchEvent, GenreSearchState> {

  final ApiRepository repository;
  final GenreCategoryListBloc genreCategoryListBloc;

  GenreSearchBloc({this.repository,this.genreCategoryListBloc}) : super(GenreSearchState(status : BaseBlocStateStatus.Initial , genreSearchItems :const <AnimationGenreSearchItem>[], genreData: GenreData(), msg:"", currentPage:1)){
    genreCategoryListBloc.listen((state){
      if(state.status == BaseBlocStateStatus.Success){
          add(GenreLoad(data: state.genreData));
      }
    });
  }


  @override
  Stream<Transition<GenreSearchEvent, GenreSearchState>> transformEvents(
      Stream<GenreSearchEvent> events,
      TransitionFunction<GenreSearchEvent, GenreSearchState> transitionFn) {

    const durationTime = 300;
    final nonDebounceStream = events.where((event){
      return event is! GenreLoad;
    });

    final debounceStream = events
        .where((event)=>event is GenreLoad)
        .debounceTime(const Duration(milliseconds: durationTime));

    return MergeStream([nonDebounceStream,debounceStream])
        .switchMap(transitionFn);
  }

  @override
  Stream<GenreSearchState> mapEventToState(
    GenreSearchEvent event,
  ) async* {
    if (event is GenreLoad) {
      yield* _mapToGenreLoad(event , state);
    }
  }

  Stream<GenreSearchState> _mapToGenreLoad(GenreLoad event , GenreSearchState state) async* {
    try {
      yield state.copyWith(status:BaseBlocStateStatus.Loading);
      String q = event.data.q;
      String page = event.page;
      String type = event.data.type;
      String startDate = event.data.startDate;
      String endDate = event.data.endDate;
      String status = event.data.status;
      String limit = event.data.limit;
      String rated = event.data.rated;
      String genre = event.data.genre;
      String genreExclude = event.data.genreExclude;
      String sort = event.data.sort;
      String orderBy = event.data.orderBy;

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
              sort:sort,orderBy: orderBy);

      if (genreItem.err) {
            yield GenreSearchState(status: BaseBlocStateStatus.Failure, msg: genreItem.msg , genreSearchItems: state.genreSearchItems , genreData: event.data);
          } else {
            List<AnimationGenreSearchItem> genreList =  genreItem.result
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
                rated: item.rated)).toList();

            if(page != "1"){
              genreList =  state.genreSearchItems..addAll(genreList);
            }

            yield GenreSearchState(
                currentPage: int.parse(page),
                status: BaseBlocStateStatus.Success,
                genreSearchItems: genreList,
                genreData: event.data);
          }
    } catch (e) {
      print("_mapToGenreLoad ${e}");
      yield state.copyWith(status:BaseBlocStateStatus.Failure ,  msg: "_mapToGenreLoad ${e}");
    }
  }
}
