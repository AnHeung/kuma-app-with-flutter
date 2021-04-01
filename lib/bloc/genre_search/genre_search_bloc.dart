import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
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
    // TODO: implement mapEventToState
  }
}
