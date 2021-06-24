import 'package:flutter/cupertino.dart';
import 'package:kuma_flutter_app/bloc/news/animation_news_bloc.dart';
import 'package:kuma_flutter_app/model/item/animation_news_item.dart';
import 'package:kuma_flutter_app/widget/common/empty_container.dart';
import 'package:kuma_flutter_app/widget/common/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/news/news_item.dart';

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
            ? Padding(
          padding: const EdgeInsets.only(top:20.0),
          child: ListView.separated(
            separatorBuilder:(context,idx){
              return const SizedBox(
                height: 30,
              );
            },
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
          ),
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