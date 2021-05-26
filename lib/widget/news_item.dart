import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_news_item.dart';
import 'package:kuma_flutter_app/screen/animation_news_detail_screen.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';
import 'package:kuma_flutter_app/widget/seperator.dart';

class NewsItemContainer extends StatelessWidget {
  final AnimationNewsItem newsItem;

  NewsItemContainer(this.newsItem);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: ()=>Navigator.of(context).push(
           PageRouteBuilder(pageBuilder: (_, __, ___) => AnimationNewsDetailScreen(newsItem),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),) ,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          child: Stack(
            children: <Widget>[
              _buildContentContainer(),
              _buildThumbnailContainer(),
            ],
          ),
        ));
  }

  Widget _buildThumbnailContainer(){
    return Container(
      margin: const EdgeInsets.only(right: 40, top: 10),
      alignment: FractionalOffset.centerLeft,
      child: Hero(
        tag: "news-item-hero${newsItem.title}",
        child: Container(
          width: 100,
          height: 100,
          child: ImageItem(
            type: ImageShapeType.CIRCLE,
            imgRes: newsItem.imageUrl,
          ),
        ),
      ),
    );
  }

  Widget _buildContentContainer(){
    return Container(
      child: _buildNewsContainer(),
      height:  200.0,
      margin: const EdgeInsets.only(left: 46.0),
      decoration: BoxDecoration(
        color: const Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          const BoxShadow(
            color: kBlack,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsContainer(){

    return Container(
      margin: const EdgeInsets.fromLTRB(76.0 , 16.0 , 16.0, 16.0),
      constraints: const BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(height: 4.0),
          CustomText(
            text: newsItem.title,
            fontColor: kWhite,
            fontSize: 15.0,
            maxLines: 2,
            isEllipsis: true,
          ),
          Separator(),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: CustomText(
              isDynamic: true,
              text: newsItem.summary,
              fontSize: 13.0,
              fontColor: kWhite,
              maxLines: 4,
              isEllipsis: true,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(padding : const EdgeInsets.only(right: 10), child: const Icon(Icons.timer, size: 20 , color: kWhite,)),
                Container(
                  alignment: Alignment.centerRight,
                  child: CustomText(
                    isDynamic: true,
                    text: newsItem.date,
                    fontSize: 8.0,
                    fontColor: kWhite,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
