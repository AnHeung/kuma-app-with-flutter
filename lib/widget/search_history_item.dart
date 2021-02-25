import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/search/search_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_main_item.dart';
import 'package:kuma_flutter_app/model/item/animation_search_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';

class SearchHistoryItem extends StatelessWidget {

  List<AnimationSearchItem> list;

  SearchHistoryItem({this.list });

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: list.isNotEmpty,
        child: Container(
          height: 300,
          child: GridView.count(
              crossAxisCount: 3,
              scrollDirection: Axis.vertical,
              crossAxisSpacing: 30,
              mainAxisSpacing: 50,
              children: list
                  .map((historyItem) => GestureDetector(
                   onTap: (){
                     BlocProvider.of<SearchBloc>(context).add(SearchHistoryWrite(searchItem: AnimationSearchItem(id: historyItem.id , image: historyItem.image , title: historyItem.title) ));
                     Navigator.pushNamed(
                       context, Routes.IMAGE_DETAIL,
                       arguments: RankingItem(
                           id: historyItem.id, title: historyItem.title));
                   },
                    child: Stack(
                          children: [
                            Container(
                              child: ImageItem(
                                type: ImageShapeType.CIRCLE,
                                imgRes: historyItem.image,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: EdgeInsets.all(7),
                                child: CustomText(text: historyItem.title, maxLines: 2, isEllipsis: true, isDynamic: true,),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () => {},
                                ),
                              ),
                            ),
                          ],
                        ),
                  ))
                  .toList()),
        ));
  }
}
