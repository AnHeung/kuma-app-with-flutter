import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
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
  final indicatorRate = 0.8;
  final topContainerHeight = 0.25;

  @override
  Widget build(BuildContext context) {
    final RankingItem infoItem = ModalRoute.of(context).settings.arguments;
    final String id = infoItem.id.toString();
    final String type = "all";

    BlocProvider.of<AnimationDetailBloc>(context)
        .add(AnimationDetailLoad(id: id, type: type));
    return Scaffold(
        appBar: _buildAppbar(
            id: id, type: type, infoItem: infoItem, context: context),
        body: BlocBuilder<AnimationDetailBloc, AnimationDetailState>(
          builder: (context, state) {
            bool isLoading = state is AnimationDetailLoadInProgress;
            if (state is AnimationDetailLoadFailure) {
              String errMsg = state is AnimationDetailLoadFailure
                  ? state.errMsg
                  : "상세페이지 에러";
              showToast(msg: errMsg);
              return RefreshContainer(
                  callback: () => BlocProvider.of<AnimationDetailBloc>(context)
                      .add(AnimationDetailLoad(id: id, type: type)));
            } else if (state is AnimationDetailLoadSuccess) {
              final AnimationDetailItem detailItem = state.detailItem;
              return _buildAniDetailContainer(
                  context: context, detailItem: detailItem);
            } else {
              return LoadingIndicator(
                isVisible: isLoading,
              );
            }
          },
        ));
  }

  Widget _buildAniDetailContainer(
      {BuildContext context, AnimationDetailItem detailItem}) {
    return ListView(shrinkWrap: true, children: [
      _buildDetailTopImageContainer(context: context, detailItem: detailItem),
      _buildDetailTopContainer(context: context, detailItem: detailItem),
      _buildDetailTopSynopsisContainer(
          context: context, detailItem: detailItem),
      Container(
        margin: EdgeInsets.only(top: 20, left: 10),
        child: CustomText(
          text: '이미지',
          fontColor: Colors.black,
          fontSize: kAnimationDetailTitleFontSize,
        ),
      ),
      _buildTopPictureContainer(pictures: detailItem.pictures),
      Container(
        margin: EdgeInsets.only(top: 20, left: 10),
        child: CustomText(
          text: '관련애니 목록',
          fontColor: Colors.black,
          fontSize: kAnimationDetailTitleFontSize,
        ),
      ),
      _buildRelateContainer(relatedItem: detailItem.relatedAnime)
    ]);
  }

  Widget _buildDetailTopContainer(
      {BuildContext context, AnimationDetailItem detailItem}) {
    final double topHeight = MediaQuery.of(context).size.height * 0.45;

    return Container(
      color: kBlack,
      height: topHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: double.infinity,
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        _buildTopContainerItem(
                            text: "${detailItem.title}",
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                        _buildTopContainerItem(
                            text: "(${detailItem.startSeason})",
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        _buildTopContainerItem(
                          text: detailItem.rank != null
                              ? '랭킹:${detailItem.rank}위'
                              : "랭킹:기록없음",
                          fontSize: 13,
                        ),
                        _buildTopContainerItem(
                          text: '시즌 시작일:${detailItem.startDate}',
                          fontSize: 13,
                        ),
                        _buildTopContainerItem(
                          text: '시즌 종료일:${detailItem.endDate}',
                          fontSize: 13,
                        ),
                        _buildTopContainerItem(
                          text: detailItem.numEpisodes != "0"
                              ? '화수:${detailItem.numEpisodes}'
                              : "화수:정보없음",
                          fontSize: 13,
                        ),
                        _buildDetailTopGenresContainer(
                          context: context,
                            genres: detailItem.genres)
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return _buildLikeIndicator(
                          height: constraints.maxHeight * indicatorRate,
                          percent: detailItem.percent,
                          percentText: detailItem.percentText,
                          indicatorColor: Colors.greenAccent);
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

  Widget _buildDetailTopGenresContainer({BuildContext context, String genres}) {

    final width = MediaQuery.of(context).size.width/8-10;
    final List genreList = genres.split(",").length > 7 ? genres.split(",").sublist(0,7) :genres.split(",") ;
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(top:10.0,bottom: 5),
        child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: genreList
                  .map((genre) => Padding(
                    padding: const EdgeInsets.only(left:10),
                    child: Container(
                          width: width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: kWhite.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: CustomText(
                            fontSize: kAnimationDetailGenreFontSize,
                            text: genre,
                            isEllipsis: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                  ))
                  .toList(),
            ) ??
            _buildTopContainerItem(
              text: "장르 : $genres",
              fontSize: kAnimationDetailGenreFontSize,
            ),
      ),
    );
  }

  Widget _buildDetailTopSynopsisContainer(
      {BuildContext context, AnimationDetailItem detailItem}) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 20, left: 10),
          child: CustomText(
            text: '개요',
            fontColor: Colors.black,
            fontSize: kAnimationDetailTitleFontSize,
          ),
        ),
        Container(
          child: CustomText(
            fontSize: kAnimationDetailFontSize,
            text: detailItem.synopsis,
            fontColor: Colors.black,
          ),
          margin: EdgeInsets.only(left: 10, top: 20),
        ),
      ],
    );
  }

  Widget _buildDetailTopImageContainer(
      {BuildContext context, AnimationDetailItem detailItem}) {
    final double topHeight = MediaQuery.of(context).size.height * topContainerHeight;
    final double imageItemWidth = MediaQuery.of(context).size.width * 0.4;

    return Container(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: topHeight,
            child: ImageItem(
              opacity: 0.8,
              imgRes: detailItem.image,
              type: ImageShapeType.FLAT,
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            width: imageItemWidth,
            height: topHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => imageAlert(
                        context, detailItem.title, [detailItem.image], 0),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPictureContainer({List<String> pictures}) {
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
                onTap: () => imageAlert(context, imgRes, pictures, idx),
                child: ImageItem(
                  imgRes: imgRes,
                  type: ImageShapeType.FLAT,
                ),
              ),
            );
          }),
    );
  }

  Widget _buildRelateContainer({List<RelatedAnimeItem> relatedItem}) {
    return relatedItem.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 10),
            child: _getPictureList(
                size: 200,
                margin: 10,
                length: relatedItem.length,
                builderFunction: (BuildContext context, idx) {
                  final RelatedAnimeItem item = relatedItem[idx];
                  return _relatedItem(context, RelatedAnimeItem(id: item.id, title: item.title, image: item.image));
                }),
          )
        : EmptyContainer(
            title: "관련 애니 없음",
            size: 50,
          );
  }

  Widget _buildLikeIndicator(
      {double height,
      double percent,
      String percentText,
      Color indicatorColor}) {
    return Container(
        margin: EdgeInsets.only(top: 5, bottom: 10),
        alignment: AlignmentDirectional.bottomCenter,
        child: CircularPercentIndicator(
          radius: height,
          lineWidth: 10.0,
          animation: true,
          percent: percent,
          center: CustomText(
            text: percentText,
            fontSize: kAnimationDetailIndicatorFontSize,
            textAlign: TextAlign.center,
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: indicatorColor,
        ));
  }

  AppBar _buildAppbar(
      {String id, String type, RankingItem infoItem, BuildContext context}) {
    return AppBar(
        title: CustomText(
          text: infoItem.title,
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

  Widget _buildTopContainerItem(
      {double fontSize, String text, FontWeight fontWeight = FontWeight.normal}) {
    return Flexible(
      flex: 1,
      child: Container(
          alignment: Alignment.center,
          child: CustomText(
            textAlign: TextAlign.center,
            text: text,
            fontSize: fontSize,
            fontWeight: fontWeight,
            maxLines: 2,
            isEllipsis: true,
            isDynamic: true,
          )),
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
                padding: EdgeInsets.only(left: 3),
                child: CustomText(
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
