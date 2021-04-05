import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/enums/category_click_status.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_all_genre_item.dart';
import 'package:kuma_flutter_app/model/genre_data.dart';
import 'package:kuma_flutter_app/model/item/animation_genre_search_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';

part 'genre_search_event.dart';

part 'genre_search_state.dart';

class   GenreSearchBloc extends Bloc<GenreSearchEvent, GenreSearchState> {
  final ApiRepository repository;

  GenreSearchBloc({this.repository}) : super(GenreSearchInitial());

  @override
  Stream<GenreSearchState> mapEventToState(
    GenreSearchEvent event,
  ) async* {
    if (event is GenreLoad) {
      yield* _mapToGenreLoad(event);
    }
  }

  Stream<GenreSearchState> _mapToGenreLoad(GenreLoad event) async* {

    yield GenreSearchLoadInProgress(clickMap: event.clickMap);
    String q = event.data.q;
    String page = event.data.page;
    String type = event.data.type;
    String startDate = event.data.startDate;
    String endDate = event.data.endDate;
    String status = event.data.status;
    String limit = event.data.limit;
    String rated = event.data.rated;
    Map<String,CategoryClickStatus> clickMap = event.clickMap;
    String genre = event.data.genre;
    String genreExclude = event.data.genreExclude;
    String sort  = event.data.sort;

    SearchMalAllGenreItem genreItem = await repository.getAllGenreItems(type, q, page, status, rated, genre, startDate, endDate, genreExclude, limit, sort);

    if(genreItem.err){
      yield GenreSearchLoadFailure(errMSg: genreItem.msg, clickMap: clickMap);
    }else{
      yield GenreSearchLoadSuccess(genreSearchItems: genreItem.result.map((item) => AnimationGenreSearchItem(id: item.id , title: item.title , image: item.image , score: item.score, startDate: item.startDate , endDate: item.endDate,
          type: item.type, airing: item.airing , episodes: item.episodes , rated: item.rated)).toList(), clickMap: clickMap, genreData: event.data);
    }
  }
}
