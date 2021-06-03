import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/news/animation_news_bloc.dart';
import 'package:kuma_flutter_app/model/item/animation_news_item.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/empty_container.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/news_item.dart';
import 'package:kuma_flutter_app/widget/refresh_container.dart';

class NewsScreen extends StatelessWidget {
  final String initialPage = "1";

  @override
  Widget build(BuildContext context) {
    String currentQuery = "";
    return Scaffold(
      appBar: NewsSearchAppbar(
        queryCallback: (query) {
          currentQuery = query;
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => BlocProvider.of<AnimationNewsBloc>(context)
            .add(AnimationNewsScrollToTop()),
        child: const Icon(Icons.arrow_circle_up_outlined),
      ),
      backgroundColor: kWhite,
      body: RefreshIndicator(
          onRefresh: () async => {
                BlocProvider.of<AnimationNewsBloc>(context)
                    .add(AnimationNewsLoad(query: currentQuery , page: initialPage))
              },
          child: BlocConsumer<AnimationNewsBloc, AnimationNewsState>(
              listener: (context, state) {
            if (state.status == AnimationNewsStatus.Failure)
              showToast(msg: state.msg);
          }, builder: (context, state) {
            return state != AnimationNewsStatus.Failure
                ? NewsScrollContainer(
                    onLoadMore: (page) {
                      BlocProvider.of<AnimationNewsBloc>(context).add(
                          AnimationNewsLoad(
                              page: page.toString(), query: currentQuery));
                    },
                    state: state,
                  )
                : RefreshContainer(
                    callback: () => BlocProvider.of<AnimationNewsBloc>(context)
                        .add(AnimationNewsLoad(page: initialPage)),
                  );
          })),
    );
  }
}

class NewsSearchAppbar extends StatefulWidget implements PreferredSizeWidget {
  NewsSearchAppbar({Key key, this.queryCallback})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  final Function(String) queryCallback;

  @override
  _NewsSearchAppbarState createState() => _NewsSearchAppbarState();

  @override
  final Size preferredSize;
}

class _NewsSearchAppbarState extends State<NewsSearchAppbar>{

  TextEditingController _controller;
  bool isClick = false;
  final Widget TitleText = CustomText(
    text: "뉴스",
    fontSize: 20.0,
    fontColor: kWhite,
    fontFamily: doHyunFont,
    textAlign: TextAlign.center,
  );

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget titleTextField = Container(
      child: TextField(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 20),
          hintText: '검색어를 입력해주세요...',
          hintStyle: const TextStyle(color: kWhite),
        ),
        onChanged: (text) {
          widget.queryCallback(text);
          BlocProvider.of<AnimationNewsBloc>(context)
              .add(AnimationNewsSearch(query: text));
        },
        style: const TextStyle(color: kWhite),
        cursorColor: kWhite,
        autofocus: true,
        controller: _controller,
      ),
    );

    return AppBar(
      centerTitle: true,
      actions: [
        Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    isClick = !isClick;
                  });
                  if (isClick) {
                    _controller?.clear();
                  } else {
                    BlocProvider.of<AnimationNewsBloc>(context).add(AnimationNewsClear());
                    widget.queryCallback("");
                  }
                },
                icon: Icon(!isClick ? Icons.search : Icons.clear)))
      ],
      title: !isClick ? TitleText : titleTextField,
    );
  }
}

class NewsScrollContainer extends StatefulWidget {
  final Function(int) onLoadMore;
  final AnimationNewsState state;

  const NewsScrollContainer({this.onLoadMore, this.state});

  @override
  _NewsScrollContainerState createState() => _NewsScrollContainerState();
}

class _NewsScrollContainerState extends State<NewsScrollContainer> {
  ScrollController _scrollController;
  String currentDate;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        _scrollController.hasClients) {
      widget.onLoadMore(widget.state.currentPage + 1);
    }
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController?.animateTo(0.0,
          curve: Curves.easeOut, duration: const Duration(milliseconds: 500));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state.status == AnimationNewsStatus.Scroll) scrollToTop();
    return Stack(
      children: [
        widget.state.newsQueryItems.length != 0
            ? ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                itemCount: widget.state.newsQueryItems.length,
                itemBuilder: (context, idx) {
                  final AnimationNewsItem newsItem = widget.state.newsQueryItems[idx];
                  if (currentDate != newsItem.date) {
                    currentDate = newsItem.date;
                  }
                  return NewsItemContainer(newsItem);
                },
              )
            : const EmptyContainer(
                title: "목록이 존재하지 않습니다.",
              ),
        LoadingIndicator(
          isVisible: widget.state.status == AnimationNewsStatus.Loading,
        )
      ],
    );
  }
}
