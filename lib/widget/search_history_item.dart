import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/search_history/search_history_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_main_item.dart';
import 'package:kuma_flutter_app/model/item/animation_search_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';

import '../model/item/animation_deatil_page_item.dart';

class SearchHistoryItem extends StatelessWidget {
  final List<AnimationSearchItem> list;

  SearchHistoryItem({this.list});

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: list.isNotEmpty,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: GridView.count(
              crossAxisCount: 3,
              scrollDirection: Axis.vertical,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
              children: list
                  .map(
                    (historyItem) => GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        BlocProvider.of<SearchHistoryBloc>(context).add(
                            SearchHistoryWrite(
                                searchItem: AnimationSearchItem(
                                    id: historyItem.id,
                                    image: historyItem.image,
                                    title: historyItem.title)));
                        Navigator.pushNamed(context, Routes.IMAGE_DETAIL,
                            arguments: AnimationDetailPageItem(
                                id: historyItem.id.toString(),
                                title: historyItem.title));
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                           Container(
                              width: 100,
                              height: 100,
                              child: ImageItem(
                                type: ImageShapeType.CIRCLE,
                                imgRes: historyItem.image,
                              ),
                            ),
                          Container(
                            alignment: Alignment.center,
                            width: 90,
                            height: 90,
                            child: CustomText(
                              fontFamily: doHyunFont,
                              fontSize: 10.0,
                              textAlign: TextAlign.center,
                              fontColor: kWhite,
                              text: historyItem.title,
                              maxLines: 2,
                              isEllipsis: true,
                              isDynamic: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList()),
        ));
  }
}
