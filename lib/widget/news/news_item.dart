import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_news_item.dart';
import 'package:kuma_flutter_app/screen/screen.dart';
import 'package:kuma_flutter_app/util/common.dart';
import 'package:kuma_flutter_app/widget/common/custom_text.dart';
import 'package:kuma_flutter_app/widget/common/image_item.dart';
import 'package:kuma_flutter_app/widget/common/seperator.dart';

class NewsItemContainer extends StatelessWidget {
  final AnimationNewsItem newsItem;

  const NewsItemContainer(this.newsItem);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: ()=> navigateWithUpAnimation(context: context, navigateScreen: AnimationNewsDetailScreen(newsItem)),
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          child: Stack(
            children: <Widget>[
              _buildContentContainer(context: context),
              _buildThumbnailContainer(),
            ],
          ),
        ));
  }

  Widget _buildThumbnailContainer(){
    return Container(
      margin: const EdgeInsets.only(right: 40, top: 10),
      alignment: FractionalOffset.centerLeft,
      child: Container(
          width: 100,
          height: 100,
          child: ImageItem(
            type: ImageShapeType.Circle,
            imgRes: newsItem.imageUrl,
          ),
      ),
    );
  }

  Widget _buildContentContainer({BuildContext context}){

    double height = MediaQuery.of(context).size.height/4;

    return Container(
      child: _buildNewsContainer(),
      height:  height,
      margin: const EdgeInsets.only(left: 46.0),
      decoration: BoxDecoration(
        color: kSoftPurple,
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
      margin: const EdgeInsets.only(left:66.0 , top:15.0 , right:10.0),
      constraints: const BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomText(
            text: newsItem.title,
            fontColor: kWhite,
            fontSize: 14.0,
            maxLines: 2,
            isEllipsis: true,
            isDynamic: true,
          ),
          Separator(),
          Container(
            child: CustomText(
              isDynamic: true,
              text: newsItem.summary,
              fontSize: 12.0,
              fontColor: kWhite,
              maxLines: 4,
              isEllipsis: true,
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(bottom: 15, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(padding : const EdgeInsets.only(right: 10), child: const Icon(Icons.timer, size: 15 , color: kWhite,)),
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
