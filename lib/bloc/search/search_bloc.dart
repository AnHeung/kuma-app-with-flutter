import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_item.dart';
import 'package:kuma_flutter_app/model/item/animation_search_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  ApiRepository repository;

  SearchBloc({this.repository}) : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchUpdate) {
      yield* _mapToSearchUpdate(event);
    } else if (event is SearchLoad) {
      yield* _mapToSearchLoad(event);
    } else if (event is SearchClear) {
      yield* _mapToSearchClear();
    } else if (event is SearchHistoryLoad) {
      yield* _mapToLoadHistory();
    } else if (event is SearchHistoryWrite) {
      yield* _mapToWriteHistory(event);
    } else if (event is SearchClearHistory) {
      yield* _mapToSearchHistoryClear();
    }
  }

  Stream<SearchState> _mapToSearchHistoryClear() async* {
    String path = await _getHistoryPath();
    final file = File('$path/search_history.json');
    _writeEmptyFile(file);
    yield SearchHistoryLoadSuccess(list: List());
  }

  Stream<SearchState> _mapToSearchUpdate(SearchUpdate event) async* {}

  Stream<SearchState> _mapToSearchClear() async* {
    yield SearchScreenClear();
  }

  Stream<SearchState> _mapToWriteHistory(SearchHistoryWrite event) async* {
    try {
      String path = await _getHistoryPath();
      final file = File('$path/search_history.json');
      if (await file.exists()) {
        AnimationSearchItem item = event.searchItem;
        await _writeJson(file, item);
        yield* _mapToLoadHistory();
      } else {
        await _writeEmptyFile(file);
      }
    } catch (e) {
      print(e);
    }
  }

  Stream<SearchState> _mapToLoadHistory() async* {
    try {
      String path = await _getHistoryPath();
      final file = File('$path/search_history.json');
      if (await file.exists()) {
        String readData = file.readAsStringSync();
        List<dynamic> list = jsonDecode(readData) ?? List();
        yield SearchHistoryLoadSuccess(
            list: list
                .map((aniItem) => AnimationSearchItem.fromJson(aniItem))
                .toList());
      } else {
        await _writeEmptyFile(file);
      }
    } catch (e) {
      print("_mapToLoadHistory $e");
    }
  }

  _writeJson(File file, AnimationSearchItem item) async {
    String contents = await file.readAsString();
    List<dynamic> savedJson = jsonDecode(contents) ?? [];
    Map<String, dynamic> newJson = item.toJson();

    int duplicateIdx = savedJson.indexWhere((data) {
      return data["id"] == newJson["id"];
    });

    bool isDuplicate = duplicateIdx != -1;

    print("idx: $duplicateIdx $isDuplicate length :${savedJson.length}");

    if (savedJson.length <= 6) {
      if (isDuplicate) {
        var lastItem = savedJson[savedJson.length - 1];
        var duplicateItem = savedJson[duplicateIdx];
        savedJson[savedJson.length - 1] = duplicateItem;
        savedJson[duplicateIdx] = lastItem;
      } else {
        if (savedJson.length == 6) savedJson.removeAt(5);
        savedJson.add(newJson);
      }
    }

    await file.writeAsString(jsonEncode(savedJson.reversed.toList()));
  }

  // _swapList(List<dynamic> list){
  //   list.asMap().forEach((idx, element) {
  //     var lastItem = list[0];
  //     list[duplicateIdx] = lastItem;
  //     list[savedJson.length-1] = newJson;
  //   });
  // }

  _writeEmptyFile(File file) async => file.writeAsString("[]");

  Future<String> _getHistoryPath() async {
    final directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    return path;
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
