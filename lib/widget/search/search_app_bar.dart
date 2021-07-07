part of 'search_widget.dart';

class SearchAppbar extends BaseAppbar {
  @override
  _SearchAppbarState createState() => _SearchAppbarState();
}

class _SearchAppbarState extends State<SearchAppbar> {
  bool isClick = false;
  Icon _searchIcon = const Icon(Icons.search);
  Widget _appBarTitle;
  String query = "";

  @override
  void initState() {
    super.initState();
    _appBarTitle = _initText();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _appBarTitle,
      actions: [
        _searchActionWidget(context),
        _deleteHistoryActionWidget(context),
      ],
    );
  }

  _clearSearchBar() {
    _searchIcon = const Icon(Icons.search);
    _appBarTitle = _initText();
  }

  Widget _initText(){
    return CustomText(
      text: kSearchInitTitle,
      fontColor: kWhite,
      fontFamily: doHyunFont,
      fontSize: 17.0,
    );
  }

  TextField _defaultTextField() {
    return TextField(

      style: const TextStyle(color: kWhite),
      onChanged: (value) {
        if(query != value) {
          query = value;
          BlocProvider.of<SearchBloc>(context)
              .add(SearchQueryUpdate(searchQuery: query));
        }
      },
      autofocus: true,
      decoration: const InputDecoration(
        hintText: kSearchHint,
        hintStyle: const TextStyle(color: kWhite),
      ),
      cursorColor: kWhite,
    );
  }

  _deleteHistoryActionWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: IconButton(
        onPressed: () => showBaseDialog(
            context: context,
            title: kSearchHistoryDeleteTitle,
            content: kSearchHistoryDeleteMsg,
            confirmFunction: () {
              BlocProvider.of<SearchHistoryBloc>(context)
                  .add(SearchHistoryClear());
              Navigator.pop(context);
            }),
        icon: const Icon(Icons.delete),
      ),
    );
  }

  _changeAppbarIcon() {
    setState(() {
      isClick = !isClick;
      if (isClick) {
        _searchIcon = const Icon(Icons.close);
        _appBarTitle = _defaultTextField();
      } else {
        _clearSearchBar();
        BlocProvider.of<SearchBloc>(context).add(SearchClear());
      }
    });
  }

  _searchActionWidget(BuildContext context) {
    return IconButton(
      onPressed: () => _changeAppbarIcon(),
      icon: _searchIcon,
    );
  }
}
