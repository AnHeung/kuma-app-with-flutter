import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/search/search_bloc.dart';
import 'package:kuma_flutter_app/model/item/animation_main_item.dart';
import 'package:kuma_flutter_app/model/item/animation_search_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';
import 'package:kuma_flutter_app/widget/default_text_field.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
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
        .debounce((_) => TimerStream(true, Duration(milliseconds: durationTime)))
        .where((value) {
      // if(value.isEmpty && !searchSubject.isClosed) _hide();
      print("value: $value");
      return value.isNotEmpty && value.toString().length > 0;
    }).listen((query){
      print('query : $query');
      BlocProvider.of<SearchBloc>(context).add(SearchLoad(searchQuery: query));
    });
  }

  @override
  void initState() {
    _createSearchEngine();
    searchController?.addListener((){
      if(searchController.text.isEmpty){
        setState(() {
          print("clear");
          searchItemList.clear();
          searchController.clear();
        });
      }else{
        print("not clear ${searchController.text}");
        _searchListener(searchController.text);
      }
    });
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

    print("searchIcon : ${this._searchIcon}");
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        searchItemList = (state is SearchItemLoadSuccess) ? state.list : List();
        list = (state is SearchLoadSuccess) ? state.list :List();
        bool isLoading = state is SearchLoadInProgress;
        bool isFailure = state is SearchLoadFailure;
        print(searchItemList);

        if (isFailure) {
          String errMsg = (state as SearchLoadFailure).errMsg ?? "에러";
          showToast(msg: errMsg);
        }
        return Scaffold(
          appBar:  AppBar(
              title: _appBarTitle,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed:_searchPressed,
                    icon: _searchIcon,
                  ),
                )
              ],
            ),
          body: Stack(
                  children: <Widget>[
                    _searchItemView(searchItemList),
                    LoadingIndicator(isVisible: isLoading,)
                  ],
                )
              ,
        );
      },
    );
  }

  _searchItemView(List<AnimationSearchItem> items) {
    return items.isNotEmpty
        ? Container(
            color: Colors.blue,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: items
                  .map((searchItem) => SearchImageItem(
                        imgRes: searchItem.image,
                        title: searchItem.title,
                            onTap: ()=>Navigator.pushReplacementNamed(context,  Routes.IMAGE_DETAIL, arguments:RankingItem(id: searchItem.id, title: searchItem.title)),
                      ))
                  .toList(),
            ),
          )
        : SizedBox();
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon =  Icon(Icons.close);
        this._appBarTitle =  TextField(
          controller: searchController,
          decoration:  InputDecoration(
              hintText: '검색...'
          ),
        );
      } else {
        this._searchIcon =  Icon(Icons.search);
        this._appBarTitle = Text('검색페이지');
        searchController.clear();
      }
    });
  }

  _searchListener(String query) => searchSubject.add(query);

}
