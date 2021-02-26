import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_main_item.dart';
import 'package:kuma_flutter_app/model/item/animation_search_season_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AnimationMainAppbar extends StatefulWidget {
  final List<AnimationSeasonItem> list;

  const AnimationMainAppbar({this.list});

  @override
  _AnimationMainAppbarState createState() => _AnimationMainAppbarState();
}

class _AnimationMainAppbarState extends State<AnimationMainAppbar> {
  final controller = PageController(initialPage: 1);


  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    List list = [Colors.blue , Colors.black, Colors.purple];

    return FlexibleSpaceBar(
        stretchModes: [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
          StretchMode.fadeTitle,
        ],
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              child: PageView(
                controller: controller,
                scrollDirection: Axis.horizontal,
                children: widget.list
                    .map((data) => GestureDetector(
                      onTap:()=>Navigator.pushNamed(context, Routes.IMAGE_DETAIL, arguments: RankingItem(id: data.id, title: data.title)) ,
                      child: Container(
                      height: double.maxFinite, //// USE THIS FOR THE MATCH WIDTH AND HEIGHT
                         width: double.maxFinite,
                            child: ImageItem(
                              type: ImageShapeType.FLAT,
                              imgRes: data.image,
                            ),
                          ),
                    ))
                    .toList(),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
              alignment: Alignment.bottomCenter,
                child:
                Container(
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: widget.list.length,
                    effect: WormEffect(
                      dotWidth: 10,
                      dotHeight: 10
                    ),
                  ),
                ),
            )
          ],
        ),
      );
  }
}

