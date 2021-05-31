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
    return Scaffold(
      appBar: AppBar(
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
        onPressed: () => BlocProvider.of<AnimationNewsBloc>(context)
            .add(AnimationNewsScrollToTop()),
        child: const Icon(Icons.arrow_circle_up_outlined),
      ),
      backgroundColor: kWhite,
      body: BlocBuilder<AnimationNewsBloc, AnimationNewsState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async => {
              BlocProvider.of<AnimationNewsBloc>(context)
                  .add(AnimationNewsLoad())
            },
            child: state != AnimationNewsStatus.Failure
                ? Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: NewsTimeContainer(
                          startDate: state.startDate,
                          endDate: state.endDate,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: NewsScrollContainer(
                          onLoadMore: (page) {
                            BlocProvider.of<AnimationNewsBloc>(context)
                                .add(AnimationNewsLoad(page: page.toString(),startDate: state.startDate ,endDate: state.endDate));
                          },
                          state: state,
                        ),
                      )
                    ],
                  )
                : RefreshContainer(
                    callback: () => BlocProvider.of<AnimationNewsBloc>(context)
                        .add(AnimationNewsLoad(page: initialPage)),
                  ),
          );
        },
      ),
    );
  }
}

class NewsTimeContainer extends StatelessWidget {

  final String startDate;
  final String endDate;

  const NewsTimeContainer({this.startDate, this.endDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => showDateTimePicker(currentDay: startDate ,context: context , onConfirm: (startDate){
              if(startDate!= null){
                BlocProvider.of<AnimationNewsBloc>(context).add(AnimationNewsChangeDate(startDate:startDate , endDate: endDate));
              }
            }),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: const Icon(
                    Icons.calendar_today_outlined,
                    color: kGrey,
                    size: 20,
                  ),
                ),
                Text(startDate),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: CustomText(text:'-', fontSize: 20.0,),
          ),
          GestureDetector(
            onTap: ()=>showDateTimePicker(currentDay: endDate ,context: context ,onConfirm: (endDate){
              if(endDate!= null){
                BlocProvider.of<AnimationNewsBloc>(context).add(AnimationNewsChangeDate(startDate:startDate , endDate: endDate));
              }
            }),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only( right: 5),
                  child: const Icon(
                    Icons.calendar_today_outlined,
                    color: kGrey,
                    size: 20,
                  ),
                ),
                Container(padding: const EdgeInsets.only(right: 10), child: Text(endDate)),
              ],
            ),
          ),
          GestureDetector(
            onTap: ()=>BlocProvider.of<AnimationNewsBloc>(context).add(AnimationNewsLoad(startDate: startDate, endDate: endDate)),
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              alignment: Alignment.center,
              width: 60,
              height: 35,
              decoration:const  BoxDecoration(
                color: kSoftPurple,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: CustomText(text:'조회' , fontFamily: doHyunFont, fontSize: 12.0,),
            ),
          )
        ],
      ),
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
        !_scrollController.position.outOfRange) {
      widget.onLoadMore(widget.state.currentPage + 1);
    }
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  scrollToTop() {
    _scrollController?.animateTo(0.0,
        curve: Curves.easeOut, duration: const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state.status == AnimationNewsStatus.Scroll) scrollToTop();
    return Stack(
      children: [
        widget.state.newsItems.length !=0
            ? ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          itemCount: widget.state.newsItems.length,
          itemBuilder: (context, idx) {
            final AnimationNewsItem newsItem = widget.state.newsItems[idx];
            if (currentDate != newsItem.date) {
              currentDate = newsItem.date;
            }
            return NewsItemContainer(newsItem);
          },
        ) : const EmptyContainer(
          title: "목록이 존재하지 않습니다.",
        ),
        LoadingIndicator(
          isVisible: widget.state.status == AnimationNewsStatus.Loading,
        )
      ],
    );
  }
}
