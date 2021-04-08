import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/bloc/genre_search/genre_category_list_bloc/genre_category_list_bloc.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_all_genre_item.dart';
import 'package:kuma_flutter_app/model/genre_data.dart';
import 'package:kuma_flutter_app/model/item/animation_genre_search_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';

part 'genre_search_event.dart';
part 'genre_search_state.dart';

class GenreSearchBloc extends Bloc<GenreSearchEvent, GenreSearchState> {

  final ApiRepository repository;
  final GenreCategoryListBloc genreCategoryListBloc;

  GenreSearchBloc({this.repository,this.genreCategoryListBloc}) : super(GenreSearchInitial()){
    genreCategoryListBloc.listen((state){
      if(state is GenreListLoadSuccess){
          add(GenreLoad(data: state.genreData));
      }
    });
  }

  @override
  Stream<GenreSearchState> mapEventToState(
    GenreSearchEvent event,
  ) async* {
    if (event is GenreLoad) {
      yield* _mapToGenreLoad(event);
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
}
