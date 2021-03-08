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
import 'package:kuma_flutter_app/widget/image_item.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/refresh_container.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AnimationDetailScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final RankingItem infoItem = ModalRoute.of(context).settings.arguments;
    final String id = infoItem.id.toString();
    final String type = "all";

    BlocProvider.of<AnimationDetailBloc>(context).add(AnimationDetailLoad(id: id, type: type));
    return Scaffold(
        appBar: _buildAppbar(id:id, type:type, infoItem: infoItem, context:  context),
        body: BlocBuilder<AnimationDetailBloc, AnimationDetailState>(
          builder: (context, state) {
            bool isLoading = state is AnimationDetailLoadInProgress;
            if (state is AnimationDetailLoadFailure) {
              String errMsg = state is AnimationDetailLoadFailure ? state.errMsg : "상세페이지 에러";
              showToast(msg: errMsg);
              return RefreshContainer(
                  callback: () => BlocProvider.of<AnimationDetailBloc>(context)
                      .add(AnimationDetailLoad(id: id, type: type)));
            } else if (state is AnimationDetailLoadSuccess) {
              final AnimationDetailItem detailItem = state.detailItem;
              return Stack(children: [
                ImageItem(
                  type: ImageShapeType.FLAT,
                  imgRes: detailItem.image,
                  opacity: 0.5,
                ),
                ListView(shrinkWrap: true, children: [
                  _buildDetailTopContainer(context: context ,detailItem: detailItem),
                  _buildTopPictureContainer(pictures: detailItem.pictures),
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
                    child: CustomText(
                      text: '관련애니 목록',
                      fontColor: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  _buildRelateContainer(relatedItem: detailItem.relatedAnime)
                ]),
              ]);
            } else {
              return LoadingIndicator(
                isVisible: isLoading,
              );
            }
          },
        ));
  }

  Widget _buildDetailTopContainer({BuildContext context, AnimationDetailItem detailItem}){

    final double topHeight = MediaQuery.of(context).size.height * 0.5;

    return Container(
      height: topHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () => imageAlert(context, detailItem.title,
                    [detailItem.image], 0),
                child: Container(
                  height: topHeight,
                  child: Hero(
                    tag: 'detail img popup tag',
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
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        _buildTopContainer(
                            text: "${detailItem.title}",
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                        _buildTopContainer(
                            text: "(${detailItem.startSeason})",
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                        _buildTopContainer(
                          text: detailItem.rank != null
                              ? '랭킹:${detailItem.rank}위'
                              : "랭킹:기록없음",
                          fontSize: 15,
                        ),
                        _buildTopContainer(
                          text: '시즌 시작일:${detailItem.startDate}',
                          fontSize: 15,
                        ),
                        _buildTopContainer(
                          text: '시즌 종료일:${detailItem.endDate}',
                          fontSize: 15,
                        ),
                        _buildTopContainer(
                          text: detailItem.numEpisodes != "0"
                              ? '화수:${detailItem.numEpisodes}'
                              : "화수:정보없음",
                          fontSize: 15,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: LayoutBuilder(builder:
                        (BuildContext context,
                        BoxConstraints constraints) {
                      return _buildLikeIndicator(height:constraints.maxHeight * 0.8 , percent: detailItem.percent, percentText: detailItem.percentText, indicatorColor:  Colors.deepPurpleAccent );
                    }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTopPictureContainer({List<String> pictures}){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: _getPictureList(
          size: 150,
          margin: 10,
          length: pictures.length,
          builderFunction: (BuildContext context, idx) {
            final String imgRes = pictures[idx];
            return AspectRatio(
              aspectRatio: 0.8,
              child: GestureDetector(
                onTap: () => imageAlert(
                    context, imgRes, pictures, idx),
                child: ImageItem(
                  imgRes: imgRes,
                  type: ImageShapeType.FLAT,
                ),
              ),
            );
          }),
    );
  }

  Widget _buildRelateContainer({List<RelatedAnimeItem> relatedItem}){
    return relatedItem.isNotEmpty ? Padding(
      padding: const EdgeInsets.only(top: 10),
      child: _getPictureList(
          size: 200,
          margin: 10,
          length: relatedItem.length,
          builderFunction: (BuildContext context, idx) {
            final RelatedAnimeItem item =
            relatedItem[idx];
            return _relatedItem(
                context,
                RelatedAnimeItem(
                    id: item.id,
                    title: item.title,
                    image: item.image));
          }),
    )
    : EmptyContainer(
    title: "관련 애니 없음",
    size: 50,
    );
  }

  Widget _buildLikeIndicator(
      {double height, double percent, String percentText, Color indicatorColor}){
    return Container(
        margin: EdgeInsets.only(top: 5),
        alignment:
        AlignmentDirectional.bottomStart,
        child: CircularPercentIndicator(
          radius: height,
          lineWidth: 15.0,
          animation: true,
          percent: percent,
          center: Text(
            percentText,
            style: TextStyle(fontSize: 13),
            textAlign: TextAlign.center,
          ),
          circularStrokeCap:
          CircularStrokeCap.round,
          progressColor: indicatorColor,
        ));
  }

  AppBar _buildAppbar({String id, String, type,RankingItem infoItem , BuildContext context}){
    return AppBar(
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
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            tooltip: "즐겨찾기",
            onPressed: () => {
              BlocProvider.of<AnimationDetailBloc>(context)
                  .add(AnimationDetailLoad(id: id, type: type))
            },
          ),
          PopupMenuButton<DeTailAnimationActions>(
            onSelected: (value) {
              switch (value) {
                case DeTailAnimationActions.ADD:
                  break;
                case DeTailAnimationActions.REFRESH:
                  BlocProvider.of<AnimationDetailBloc>(context)
                      .add(AnimationDetailLoad(id: id, type: type));
                  break;
              }
            },
            itemBuilder: (BuildContext context) =>
            <PopupMenuItem<DeTailAnimationActions>>[
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
        ]);
  }

  Widget _buildTopContainer(
      {int fontSize, String text, FontWeight fontWeight = FontWeight.normal}) {
    return Flexible(
      flex: 1,
      child: Container(
          alignment: Alignment.centerLeft,
          child: CustomText(
              text: text,
              fontSize: fontSize,
              fontWeight: fontWeight,
              maxLines: 2,
              isEllipsis: true,
              isDynamic: true,
              fontColor: Colors.black)),
    );
  }

  Widget _getPictureList(
      {double size, double margin, int length, Function builderFunction}) {
    return Container(
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

  Widget _relatedItem(BuildContext context, RelatedAnimeItem item) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, Routes.IMAGE_DETAIL,
            arguments: RankingItem(id: item.id, title: item.title));
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
                child: CustomText(
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
