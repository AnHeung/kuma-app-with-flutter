import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/model/item/animation_search_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  ApiRepository repository;

  SearchBloc({this.repository}) : super(SearchLoadInProgress());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
  }
}
