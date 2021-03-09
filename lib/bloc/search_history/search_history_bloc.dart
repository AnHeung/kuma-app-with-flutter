import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/model/item/animation_search_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

part 'search_history_event.dart';
part 'search_history_state.dart';

class SearchHistoryBloc extends Bloc<SearchHistoryEvent, SearchHistoryState> {

  final ApiRepository repository;

  SearchHistoryBloc({this.repository}) : super(SearchHistoryInitial());

  @override
  Stream<SearchHistoryState> mapEventToState(
    SearchHistoryEvent event,
  ) async* {
    if (event is SearchHistoryLoad) {
    yield* _mapToLoadHistory();
    } else if (event is SearchHistoryWrite) {
    yield* _mapToWriteHistory(event);
    } else if (event is SearchHistoryClear) {
    yield* _mapToSearchHistoryClear();
    }
  }


  Stream<SearchHistoryState> _mapToSearchHistoryClear() async* {
    String path = await _getHistoryPath();
    final file = File('$path/search_history.json');
    _writeEmptyFile(file);
    yield SearchHistoryLoadSuccess(list: []);
  }

  Stream<SearchHistoryState> _mapToLoadHistory() async* {
    try {
      String path = await _getHistoryPath();
      final file = File('$path/search_history.json');
      if (await file.exists()) {
        String readData = file.readAsStringSync();
        if(readData.isNotEmpty){
          List<dynamic> list = jsonDecode(readData) ?? [];
          yield SearchHistoryLoadSuccess(
              list: list
                  .map((aniItem) => AnimationSearchItem.fromJson(aniItem))
                  .toList());
        }
      } else {
        await _writeEmptyFile(file);
      }
    } catch (e) {
      print("_mapToLoadHistory $e");
    }
  }

  Stream<SearchHistoryState> _mapToWriteHistory(SearchHistoryWrite event) async* {
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

  _writeJson(File file, AnimationSearchItem item) async {
    String contents = await file.readAsString();

    if(contents.isEmpty) await _writeEmptyFile(file);
    List<dynamic> savedJson = jsonDecode(contents) ?? [];
    Map<String, dynamic> newJson = item.toJson();

    int duplicateIdx = savedJson.indexWhere((data) {
      return data["id"] == newJson["id"];
    });

    bool isDuplicate = duplicateIdx != -1;

    print("idx: $duplicateIdx $isDuplicate length :${savedJson.length}");

    if (savedJson.length <= 9) {
      if (isDuplicate) {
        var lastItem = savedJson[savedJson.length - 1];
        var duplicateItem = savedJson[duplicateIdx];
        savedJson[savedJson.length - 1] = duplicateItem;
        savedJson[duplicateIdx] = lastItem;
      } else {
        if (savedJson.length == 9) savedJson.removeAt(8);
        savedJson.add(newJson);
      }
    }

    await file.writeAsString(jsonEncode(savedJson.reversed.toList()));
  }

  _writeEmptyFile(File file) async => file.writeAsString("[]");

  Future<String> _getHistoryPath() async {
    final directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    return path;
  }
}
