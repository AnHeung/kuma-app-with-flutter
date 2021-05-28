import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/news/animation_news_bloc.dart';
import 'package:kuma_flutter_app/model/item/animation_news_item.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/news_item.dart';

class NewsScreen extends StatelessWidget {
  final String initialPage = "1";

  @override
  Widget build(BuildContext context) {

    final NewsScrollContainer newsScrollContainer = NewsScrollContainer(onLoadMore: (page) {
      BlocProvider.of<AnimationNewsBloc>(context)
          .add(AnimationNewsLoad(page: page.toString()));
    });

    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(icon: const Icon(Icons.calendar_today_outlined, color: kWhite,), onPressed: ()=>{

            }),
          )
        ],
        title: CustomText(
          text: "뉴스",
          fontSize: 20.0,
          fontColor: kWhite,
          fontFamily: doHyunFont,
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: ()=>BlocProvider.of<AnimationNewsBloc>(context).add(AnimationNewsScrollToTop()),
        child: const Icon(Icons.arrow_circle_up_outlined),
      ),
      backgroundColor: kSoftPurple,
      body: RefreshIndicator(
        onRefresh: () async => {
          BlocProvider.of<AnimationNewsBloc>(context)
              .add(const AnimationNewsLoad())
        },
        child: newsScrollContainer,
      ),
    );
  }
}

class NewsScrollContainer extends StatefulWidget {
  final Function(int) onLoadMore;

  NewsScrollContainer({this.onLoadMore});

  @override
  _NewsScrollContainerState createState() => _NewsScrollContainerState();
}

class _NewsScrollContainerState extends State<NewsScrollContainer> {
  ScrollController _scrollController;
  int currentPage;
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
        !_scrollController.position.outOfRange) {
      widget.onLoadMore(currentPage + 1);
    }
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  scrollToTop(){
    _scrollController?.animateTo(0.0,  curve: Curves.easeOut,
        duration: const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnimationNewsBloc, AnimationNewsState>(
      listener: (context,state){
        if(state.status == AnimationNewsStatus.Scroll) scrollToTop();
      },
        builder: (context, state) {
      currentPage = state.currentPage;
      return Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            itemCount: state.newsItems.length,
            itemBuilder: (context, idx) {
              final AnimationNewsItem newsItem = state.newsItems[idx];
              if (currentDate != newsItem.date) {
                currentDate = newsItem.date;
              }
              return NewsItemContainer(newsItem);
            },
          ),
          LoadingIndicator(
            isVisible: state.status == AnimationNewsStatus.Loading,
          )
        ],
      );
    });
  }
}
