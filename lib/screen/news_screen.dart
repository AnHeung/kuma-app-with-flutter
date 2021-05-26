import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/news/animation_news_bloc.dart';
import 'package:kuma_flutter_app/model/item/animation_news_item.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/news_item.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String currentDate;

    return BlocBuilder<AnimationNewsBloc, AnimationNewsState>(
      builder: (context, state) {
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
          backgroundColor: kSoftPurple,
          body: Center(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.newsItems.length,
              itemBuilder: (context, idx) {
                final AnimationNewsItem newsItem = state.newsItems[idx];
                if (currentDate != newsItem.date ) {
                  currentDate = newsItem.date;
                }
                return NewsItemContainer(newsItem);
              },
            ),
          ),
        );
      },
    );
  }
}
