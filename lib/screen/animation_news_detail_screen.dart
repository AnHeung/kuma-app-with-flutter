import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/model/item/animation_news_item.dart';
import 'package:kuma_flutter_app/widget/webview_container.dart';

class AnimationNewsDetailScreen extends StatelessWidget {

  final AnimationNewsItem newsItem;

  AnimationNewsDetailScreen(this.newsItem);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(newsItem.title),
      ),
      body:  Container(
        constraints: const BoxConstraints.expand(),
        color: kSoftPurple,
        child: WebViewContainer(
            url: newsItem.url,
        ),
      ),
    );
  }

}
