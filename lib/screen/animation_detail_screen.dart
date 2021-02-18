import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation/animation_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation_detail/animation_detail_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_detail_item.dart';
import 'package:kuma_flutter_app/model/item/animation_main_item.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/empty_container.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AnimationDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RankingItem infoItem = ModalRoute.of(context).settings.arguments;
    String id = infoItem.id.toString();
    String type = "all";

    BlocProvider.of<AnimationDetailBloc>(context)
        .add(AnimationDetailLoad(id: id, type: type));

    return BlocBuilder<AnimationDetailBloc, AnimationDetailState>(
      builder: (context, state) {
        bool isLoading = state is AnimationDetailLoadInProgress;
        final AnimationDetailItem detailItem = (state is AnimationDetailLoadSuccess) ? state.detailItem : null;

        return Scaffold(
          appBar: AppBar(
            title: CustomText(text: infoItem.title, fontSize: 15,),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                tooltip: "설정",
                onPressed: () => {
                  BlocProvider.of<AnimationDetailBloc>(context)
                      .add(AnimationDetailLoad(id: id, type: type))
                },
              ),
            ],
          ),
          body: Stack(
            children: [
              detailItem != null
                  ? Stack(children: [
                      ImageItem(type: ImageShapeType.FLAT ,imgRes: detailItem.image, opacity: 0.5,),
                      Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: ImageItem(
                                      type: ImageShapeType.FLAT,
                                      imgRes: detailItem.image,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Container(
                                          child: CustomText(text:"${detailItem.title}(${detailItem.startSeason})" , fontSize:20, fontColor: Colors.black, isEllipsis: true,),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          alignment: AlignmentDirectional.centerStart,
                                          child: CustomText(text:detailItem.rank != null ? '랭킹:${detailItem.rank}위' : '랭킹: 기록없음', fontSize: 15 , maxLines: 2 , isEllipsis: true,fontColor: Colors.black)),
                                        Container(
                                            margin: EdgeInsets.only(top: 5),
                                            alignment: AlignmentDirectional.centerStart,
                                            child: CustomText(text:'시즌 시작일:${detailItem.startDate}', fontSize: 15 , maxLines: 2 , isEllipsis: true,fontColor: Colors.black)),
                                        Container(
                                            margin: EdgeInsets.only(top: 5),
                                            alignment: AlignmentDirectional.centerStart,
                                            child: CustomText(text:'시즌 종료일:${detailItem.endDate}', fontSize: 15 , maxLines: 2 , isEllipsis: true,fontColor: Colors.black)),
                                        Container(
                                            margin: EdgeInsets.only(top: 5),
                                            alignment: AlignmentDirectional.centerStart,
                                            child: CustomText(text: detailItem.numEpisodes != "0" ? '화수:${detailItem.numEpisodes}' : "화수:정보없음", fontSize: 15 , maxLines: 2 , isEllipsis: true,fontColor: Colors.black)),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                              margin: EdgeInsets.only(top: 5),
                                              alignment: AlignmentDirectional.bottomStart ,
                                              child: CircularPercentIndicator(
                                                radius: 120.0,
                                                lineWidth: 13.0,
                                                animation: true,
                                                percent:  double.parse(detailItem.star)/10.ceil(),
                                                center: Text("인기 그래프 \n${double.parse(detailItem.star)*10.ceil()}%", style:TextStyle(fontSize: 15), textAlign: TextAlign.center,),
                                                circularStrokeCap: CircularStrokeCap.round,
                                                progressColor: Colors.blue,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: CustomText(fontSize: 13, text: detailItem.synopsis,fontColor: Colors.black,),
                                  margin: EdgeInsets.only(left: 10),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ])
                  : EmptyContainer(),
              LoadingIndicator(
                isVisible: isLoading,
              )
            ],
          ),
        );
      },
    );
  }
}
