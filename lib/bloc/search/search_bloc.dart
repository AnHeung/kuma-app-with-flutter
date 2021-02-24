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

  SearchBloc({this.repository}): super(SearchInit());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if(event is SearchUpdate){
      yield* _mapToSearchUpdate(event);
    }else if(event is SearchLoad){
      yield* _mapToSearchLoad(event);
    }else if(event is SearchClear){
      yield* _mapToSearchClear();
    }else if(event is SearchHistoryLoad){
      yield* _mapToLoadHistory();
    }else if(event is SearchHistoryWrite){
      yield* _mapToWriteHistory(event);
    }
  }

  Stream<SearchState> _mapToSearchInit(SearchInit event) async* {
    yield SearchLoadSuccess();
  }

  Stream<SearchState> _mapToSearchUpdate(SearchUpdate event) async*{

  }

  Stream<SearchState> _mapToWriteHistory(SearchHistoryWrite event) async*{
    try {
      String path = await _getHistoryPath();
      final file =  File('$path/search_history.json');
      if(await file.exists()){
        await _writeJson(file, "5","6");
      }else{
        await _writeEmptyFile(file);
      }
    } catch (e) {
      print(e);
    }
  }

  Stream<SearchState> _mapToLoadHistory() async*{
      try {
        String path = await _getHistoryPath();
        final file =  File('$path/search_history.json');
        if(await file.exists()){
          String readData = file.readAsStringSync();
          yield SearchItemLoadSuccess(list:List());
        }else{
          await _writeEmptyFile(file);
          yield SearchItemLoadSuccess(list:List());
        }
      } catch (e) {
        print(e);
      }
    }


    Future<bool> _writeJson(File file,String key, String value) async{
      String contents = await file.readAsString();
      print("contents : $contents");
      Map<String, dynamic> savedJson = jsonDecode(contents) ?? {};
      Map<String, dynamic> newJson = {key: value};

      String _jsonString;
      print('1.(_writeJson) _newJson: $newJson');
      //2. Update _json by adding _newJson<Map> -> _json<Map>
      savedJson.addAll(newJson);
      print('2.(_writeJson) _json(updated): $savedJson');
      //3. Convert _json ->_jsonString
      _jsonString = jsonEncode(savedJson);
      print('3.(_writeJson) _jsonString: $_jsonString\n - \n');
      //4. Write _jsonString to the _filePath
      await file.writeAsString(_jsonString);
    }

   _writeEmptyFile(File file) async => file.writeAsString("{}");


    Future<String> _getHistoryPath() async{
      final directory = await getApplicationDocumentsDirectory();
      String path = directory.path;
      return path;
    }

  Stream<SearchState> _mapToSearchClear() async* {
    yield SearchItemLoadSuccess();
  }

  Stream<SearchState> _mapToSearchLoad(SearchLoad event) async*{
    yield SearchLoadInProgress();
    String query = event.searchQuery;
    SearchMalApiItem searchItems =  await repository.getSearchItems(query);
    if(searchItems.err){
      yield SearchLoadFailure(errMsg: searchItems.msg);
    }
    else{
      yield SearchItemLoadSuccess(list: searchItems.result.map((result) => AnimationSearchItem(id: result.id, title: result.title , image: result.image)).toList());
    }
  }

}
