import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/enums/base_bloc_state_status.dart';
import 'package:kuma_flutter_app/model/item/animation_search_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:kuma_flutter_app/util/common.dart';

part 'search_history_event.dart';
part 'search_history_state.dart';

class SearchHistoryBloc extends Bloc<SearchHistoryEvent, SearchHistoryState> {

  final ApiRepository repository;

  SearchHistoryBloc({this.repository}) : super(const SearchHistoryState());

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
    try {
      yield state.copyWith(status: BaseBlocStateStatus.Loading, list: state.list);
      String path = await _getHistoryPath();
      if(!path.isNullEmptyOrWhitespace) {
            final file = File('$path/$kSearchHistoryPath');
            _writeEmptyFile(file);
            yield const SearchHistoryState(
                status: BaseBlocStateStatus.Success, list: []);
          }
    } catch (e) {
      print("_mapToSearchHistoryClear error :$e");
      yield state.copyWith(status: BaseBlocStateStatus.Failure ,msg: kSearchHistoryDeleteErrMsg);
    }
  }

  Stream<SearchHistoryState> _mapToLoadHistory() async* {
    try {
      yield SearchHistoryState(status: BaseBlocStateStatus.Loading, list: state.list );
      String path = await _getHistoryPath();
      final file = File('$path/$kSearchHistoryPath');
      if (await file.exists()) {
        String readData = file.readAsStringSync();
        if(readData.isNotEmpty){
          List<dynamic> list = jsonDecode(readData) ?? [];
          yield SearchHistoryState(
            status: BaseBlocStateStatus.Success,
              list: list
                  .map((aniItem) => AnimationSearchItem.fromJson(aniItem))
                  .toList());
        }
      } else {
        await _writeEmptyFile(file);
      }
    } catch (e) {
      print("_mapToLoadHistory error $e");
      yield const SearchHistoryState(status: BaseBlocStateStatus.Failure,  msg: kSearchHistoryLoadErrMsg );
    }
  }

  Stream<SearchHistoryState> _mapToWriteHistory(SearchHistoryWrite event) async* {
    try {
      String path = await _getHistoryPath();
      final file = File('$path/$kSearchHistoryPath');
      if (await file.exists()) {
        AnimationSearchItem item = event.searchItem;
        await _writeJson(file, item);
        yield* _mapToLoadHistory();
      } else {
        await _writeEmptyFile(file);
      }
    } catch (e) {
      print("_mapToWriteHistory error $e");
      yield state.copyWith(status: BaseBlocStateStatus.Failure,  msg: kSearchHistoryWriteErrMsg );
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

    if (isDuplicate) {
        savedJson.removeAt(duplicateIdx);
        savedJson.insert(0, newJson);
      } else {
        savedJson.insert(0, newJson);
      }
    await file.writeAsString(jsonEncode(savedJson.toList()));
  }

  _writeEmptyFile(File file) async => file.writeAsString("[]");

  Future<String> _getHistoryPath() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      String path = directory.path;
      return path;
    }catch(e){
      print('_getHistoryPath error :$e');
      return '';
    }
  }
}
