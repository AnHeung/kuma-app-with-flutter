import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/search/search_bloc.dart';
import 'package:kuma_flutter_app/model/item/animation_main_item.dart';
import 'package:kuma_flutter_app/model/item/animation_search_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';
import 'package:kuma_flutter_app/widget/default_text_field.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/search_history_item.dart';
import 'package:kuma_flutter_app/widget/search_image_item.dart';
import 'package:rxdart/rxdart.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<AnimationSearchItem> searchItemList = List();
  List<AnimationSearchItem> list = List();
  TextEditingController searchController = TextEditingController();
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = Text('검색페이지');
  PublishSubject<String> searchSubject = PublishSubject();
  final int durationTime = 500;

  _createSearchEngine() {
    searchSubject.stream
        .debounce(
            (_) => TimerStream(true, Duration(milliseconds: durationTime)))
        .where((value) {
      print("value: $value");
      return value.isNotEmpty && value.toString().length > 0;
    }).listen((query) {
      if (!searchSubject.isClosed)
        BlocProvider.of<SearchBloc>(context)
            .add(SearchLoad(searchQuery: query));
    });
  }

  @override
  void initState() {
    _createSearchEngine();
    searchController?.addListener(_searchListener);
    BlocProvider.of<SearchBloc>(context).add(SearchHistoryLoad());
    super.initState();
  }

  @override
  void dispose() {
    searchController?.dispose();
    searchSubject?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: _appBarTitle,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: _searchPressed,
              icon: _searchIcon,
            ),
          ),
            IconButton(
              onPressed: ()=>BlocProvider.of<SearchBloc>(context).add(SearchClearHistory()),
              icon: Icon(Icons.autorenew),
            ),
        ],
      ),
      body: BlocListener<SearchBloc, SearchState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case SearchLoadFailure:
              String errMsg = (state as SearchLoadFailure).errMsg ?? "에러";
              showToast(msg: errMsg);
              break;
            case SearchScreenClear:
              _clearScreen();
              break;
          }
        },
        child: Stack(
          children: <Widget>[
            Column(
              children: [_searchHistoryView()],
            ),
            _searchItemView(),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) => LoadingIndicator(
                isVisible: state is SearchLoadInProgress,
              ),
            )
          ],
        ),
      ),
    );
  }

  _searchHistoryView() {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (prev, cur) => cur is SearchHistoryLoadSuccess,
      builder: (context, state) {
        List<AnimationSearchItem> list =
            (state is SearchHistoryLoadSuccess) ? state.list : List();
        return Container(
          margin: EdgeInsets.only(top: 30),
          child: SearchHistoryItem(
            list: list,
          ),
        );
      },
    );
  }

  _searchItemView() {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (prev, cur) => cur is SearchItemLoadSuccess,
      builder: (context, state) {
        searchItemList = (state is SearchItemLoadSuccess) ? state.list : List();
        return Visibility(
          visible: searchItemList.isNotEmpty,
          child: Container(
            color: Colors.blue,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: searchItemList
                  .map((searchItem) => SearchImageItem(
                        imgRes: searchItem.image,
                        title: searchItem.title,
                        onTap: () {
                          BlocProvider.of<SearchBloc>(context)
                              .add(SearchClear());
                          BlocProvider.of<SearchBloc>(context).add(
                              SearchHistoryWrite(
                                  searchItem: AnimationSearchItem(
                                      id: searchItem.id,
                                      image: searchItem.image,
                                      title: searchItem.title)));
                          Navigator.pushNamed(context, Routes.IMAGE_DETAIL,
                              arguments: RankingItem(
                                  id: searchItem.id, title: searchItem.title));
                        },
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close);
        this._appBarTitle = TextField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[ㄱ-ㅎ|가-힣|ㆍ|ᆢ'))
          ],
          autofocus: true,
          controller: searchController,
          decoration: InputDecoration(hintText: '검색...'),
        );
      } else {
        this._searchIcon = Icon(Icons.search);
        this._appBarTitle = Text('검색페이지');
        searchController.clear();
      }
    });
  }

  _clearScreen() {
    setState(() {
      searchItemList.clear();
      searchController.text = "";
      searchController.clear();
    });
  }

  _searchListener() {
    if (searchController.text.isEmpty) _clearScreen();
    else searchSubject.add(searchController.text);
  }
}
