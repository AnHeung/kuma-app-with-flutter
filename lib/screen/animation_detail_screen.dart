import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation_detail/animation_detail_bloc.dart';
import 'package:kuma_flutter_app/enums/detail_animation_actions.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_detail_item.dart';
import 'package:kuma_flutter_app/model/item/animation_main_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/empty_container.dart';
import 'package:kuma_flutter_app/widget/empty_img_container.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AnimationDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RankingItem infoItem = ModalRoute.of(context).settings.arguments;
    String id = infoItem.id.toString();
    String type = "all";

    BlocProvider.of<AnimationDetailBloc>(context).add(AnimationDetailLoad(id: id, type: type));

    return BlocBuilder<AnimationDetailBloc, AnimationDetailState>(
      builder: (context, state) {
        bool isLoading = state is AnimationDetailLoadInProgress;
        final AnimationDetailItem detailItem =
            (state is AnimationDetailLoadSuccess) ? state.detailItem : null;

        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, isScrolled) {
              return [
                SliverAppBar(
                  title: CustomText(
                    text: infoItem.title,
                    fontSize: 15,
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.refresh),
                      tooltip: "재시작",
                      onPressed: () => {
                        BlocProvider.of<AnimationDetailBloc>(context)
                            .add(AnimationDetailLoad(id: id, type: type))
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite, color: Colors.red,),
                      tooltip: "즐겨찾기",
                      onPressed: () => {
                        BlocProvider.of<AnimationDetailBloc>(context)
                            .add(AnimationDetailLoad(id: id, type: type))
                      },
                    ),
                    PopupMenuButton<DeTailAnimationActions>(
                      onSelected: (value){
                        switch(value){
                          case DeTailAnimationActions.ADD:
                            break;
                          case DeTailAnimationActions.REFRESH:
                            BlocProvider.of<AnimationDetailBloc>(context)
                                .add(AnimationDetailLoad(id: id, type: type));
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuItem<DeTailAnimationActions>>[
                        PopupMenuItem<DeTailAnimationActions>(
                          value: DeTailAnimationActions.ADD,
                          child: Text('배치에 추가'),
                        ),
                        PopupMenuItem<DeTailAnimationActions>(
                          value: DeTailAnimationActions.REFRESH,
                          child: Text('새로고침'),
                        ),
                      ],
                    )
                  ],
                  // floating 설정. SliverAppBar는 스크롤 다운되면 화면 위로 사라짐.
                  // true: 스크롤 업 하면 앱바가 바로 나타남. false: 리스트 최 상단에서 스크롤 업 할 때에만 앱바가 나타남
                  floating: true,
                  pinned: true,
                  // flexibleSpace에 플레이스홀더를 추가
                  // 최대 높이
                  expandedHeight: 50,
                )
              ];
            },
            body: detailItem != null
                ? Stack(children: [
                    ImageItem(
                      type: ImageShapeType.FLAT,
                      imgRes: detailItem.image,
                      opacity: 0.5,
                    ),
                    ListView(children: [
                      Container(
                        height: 350,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: GestureDetector(
                                  onTap: ()=>imageAlert(context, detailItem.title, detailItem.image),
                                  child: Container(
                                    height: 350,
                                    child: Hero(
                                      tag:'detail img popup tag',
                                      child: ImageItem(
                                        type: ImageShapeType.FLAT,
                                        imgRes: detailItem.image,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: double.infinity,
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: CustomText(
                                        maxLines: 2,
                                        text:
                                            "${detailItem.title}",
                                        fontSize: 20,
                                        fontColor: Colors.black,
                                        isEllipsis: true,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: CustomText(
                                        text:
                                        "(${detailItem.startSeason})",
                                        fontSize: 20,
                                        fontColor: Colors.black,
                                        isEllipsis: true,
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(top: 5),
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: CustomText(
                                            text: detailItem.rank!= null ? '랭킹:${detailItem.rank}위' : "랭킹:기록없음",
                                            fontSize: 15,
                                            maxLines: 2,
                                            isEllipsis: true,
                                            fontColor: Colors.black)),
                                    Container(
                                        margin: EdgeInsets.only(top: 5),
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: CustomText(
                                            text: '시즌 시작일:${detailItem.startDate}',
                                            fontSize: 15,
                                            maxLines: 2,
                                            isEllipsis: true,
                                            fontColor: Colors.black)),
                                    Container(
                                        margin: EdgeInsets.only(top: 5),
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: CustomText(
                                            text:
                                                '시즌 종료일:${detailItem.endDate}',
                                            fontSize: 15,
                                            maxLines: 2,
                                            isEllipsis: true,
                                            fontColor: Colors.black)),
                                    Container(
                                        margin: EdgeInsets.only(top: 5),
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: CustomText(
                                            text: detailItem.numEpisodes != "0"
                                                ? '화수:${detailItem.numEpisodes}'
                                                : "화수:정보없음",
                                            fontSize: 15,
                                            maxLines: 2,
                                            isEllipsis: true,
                                            fontColor: Colors.black)),
                                    Expanded(
                                      child: Container(
                                          margin: EdgeInsets.only(top: 5),
                                          alignment:
                                              AlignmentDirectional.bottomStart,
                                          child: CircularPercentIndicator(
                                            radius: 110.0,
                                            lineWidth: 15.0,
                                            animation: true,
                                            percent: detailItem.percent,
                                            center: Text(
                                              detailItem.percentText,
                                              style: TextStyle(fontSize: 13),
                                              textAlign: TextAlign.center,
                                            ),
                                            circularStrokeCap:
                                                CircularStrokeCap.round,
                                            progressColor: Colors.deepPurpleAccent,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:10, bottom: 10),
                        child: _getPictureList(size: 150, margin: 10 ,length:detailItem.pictures.length ,builderFunction:
                            (BuildContext context, idx){
                          final String imgRes = detailItem.pictures[idx];
                          return AspectRatio(
                            aspectRatio: 0.8,
                            child: GestureDetector(
                              onTap:()=>imageAlert(context, imgRes, imgRes),
                              child: ImageItem(
                                imgRes: imgRes,
                                type: ImageShapeType.FLAT,
                              ),
                            ),
                          );
                        }),
                      ),
                      Container(
                        child: CustomText(
                          fontSize: 15,
                          text: detailItem.synopsis,
                          fontColor: Colors.black,
                        ),
                        margin: EdgeInsets.only(left: 10, top: 10),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, left: 10),
                        child: CustomText(text: '관련애니 목록',fontColor: Colors.black,fontSize: 30,),
                      ),
                      detailItem.relatedAnime.isNotEmpty  ?
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: _getPictureList(size: 200, margin: 10 , length:detailItem.relatedAnime.length, builderFunction: (BuildContext context, idx){
                          final RelatedAnimeItem item =  detailItem.relatedAnime[idx];
                          return _relatedItem(context, RelatedAnimeItem(id: item.id, title: item.title,  image: item.image));
                        }),
                      ) : EmptyContainer(title: '관련 애니 없음',)
                    ]),
                  ])
                : LoadingIndicator(
                    isVisible: isLoading,
                  ),
          ),
        );
      },
    );
  }


  Widget _getPictureList({double size, double margin, int length, Function builderFunction}){
    return  Container(
      height: size,
      width: size,
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: margin,
            );
          },
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: length,
          shrinkWrap: true,
          itemBuilder: builderFunction),
    );
  }


  Widget _relatedItem(BuildContext context, RelatedAnimeItem item){
      return  GestureDetector(
        onTap: (){
          Navigator.pushReplacementNamed(context,  Routes.IMAGE_DETAIL, arguments:RankingItem(id: item.id, title: item.title));
        },
        child: Container(
          padding: EdgeInsets.only(left: 8, bottom: 8),
          height: 150,
          width: 150,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  child:CustomText(
                    fontSize: 17,
                    fontColor: Colors.black,
                    text: item.title,
                    maxLines: 2,
                    isDynamic: true,
                    isEllipsis: true,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.centerLeft,
                  child: ImageItem(
                    imgRes: item.image,
                    type: ImageShapeType.CIRCLE,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  }
}

