import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/animation_detail/animation_detail_bloc.dart';
import 'package:kuma_flutter_app/bloc/character/character_bloc.dart';
import 'package:kuma_flutter_app/enums/detail_animation_actions.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/enums/navigation_push_type.dart';
import 'package:kuma_flutter_app/model/item/animation_deatil_page_item.dart';
import 'package:kuma_flutter_app/model/item/animation_detail_item.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';
import 'package:kuma_flutter_app/widget/bottom_character_item_container.dart';
import 'package:kuma_flutter_app/widget/bottom_video_item_container.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/empty_container.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';
import 'package:kuma_flutter_app/widget/image_scroll_container.dart';
import 'package:kuma_flutter_app/widget/image_text_scroll_item.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/more_container.dart';
import 'package:kuma_flutter_app/widget/refresh_container.dart';
import 'package:kuma_flutter_app/widget/title_container.dart';
import 'package:kuma_flutter_app/widget/youtube_player.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../model/item/animation_deatil_page_item.dart';
import '../repository/api_repository.dart';

class AnimationDetailScreen extends StatelessWidget {
  final indicatorRate = 0.82;
  final topImageContainerHeightRate = 0.25;
  final topContainerHeightRate = 0.5;
  final topImageWidthRate = 0.4;

  @override
  Widget build(BuildContext context) {


    final AnimationDetailPageItem infoItem =
        ModalRoute.of(context).settings.arguments;
    final String id = infoItem.id;
    const String type = "all";

    BlocProvider.of<AnimationDetailBloc>(context)
        .add(AnimationDetailLoad(id: id));

    return BlocBuilder<AnimationDetailBloc, AnimationDetailState>(
      builder: (context, state) {
        final AnimationDetailItem detailItem = state.detailItem;
        bool isLoading = state.status == AnimationDetailStatus.loading;

        if (AnimationDetailStatus.failure == state.status) {
          String errMsg = state.status == AnimationDetailStatus.failure
              ? state.msg
              : "상세페이지 에러";
          showToast(msg: errMsg);
          return RefreshContainer(
              callback: () => BlocProvider.of<AnimationDetailBloc>(context)
                  .add(AnimationDetailLoad(id: id)));
        }

        return Scaffold(
          appBar: _buildAppbar(
              id: id,
              type: type,
              infoItem: infoItem,
              context: context,
              detailItem: state.detailItem),
          body: Stack(
            children: [
              _buildAniDetailContainer(
                  context: context, detailItem: detailItem),
              LoadingIndicator(
                isVisible: isLoading,
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildAniDetailContainer(
      {BuildContext context, AnimationDetailItem detailItem}) {
    return detailItem != null
        ? ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const ClampingScrollPhysics(),
            children: [
                _buildDetailTopImageContainer(
                    context: context, detailItem: detailItem),
                _buildDetailTopYoutubeContainer(
                    context: context, selectVideoUrl: detailItem.selectVideoUrl),
                _buildDetailTopContainer(
                    context: context, detailItem: detailItem),
                _buildCharacterTitleContainer(
                    context: context, characters: detailItem.characterItems),
                _buildTopCharacterContainer(characters: detailItem.characterItems),
                _buildDetailTopSynopsisContainer(
                    context: context, detailItem: detailItem),
              const TitleContainer(title: kAnimationDetailImageTitle),
                ImageScrollItemContainer(title :"관련 이미지", images: detailItem.pictures),
              const TitleContainer(title: kAnimationDetailRelateTitle),
                _buildRelateContainer(relatedItem: detailItem.relatedAnime),
              const TitleContainer(title: kAnimationDetailRecommendTitle),
                _buildRecommendationContainer(
                    recommendationItems: detailItem.recommendationAnimes)
              ])
        : EmptyContainer(
            title: "상세 페이지 내용 없음",
          );
  }

  Widget _buildCharacterTitleContainer(
      {BuildContext context, List<CharacterItem> characters}) {

    return Container(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          const TitleContainer(title: kAnimationDetailCharacterTitle,),
          const Spacer(),
          MoreContainer(onClick: ()=>print('test'),),
        ],
      ),
    );
  }

  Widget _buildDetailTopYoutubeContainer(
      {BuildContext context, String selectVideoUrl}) {

    final GlobalKey playerKey = GlobalKey();

    return Visibility(
      visible: selectVideoUrl.isNotEmpty,
      child: YoutubeVideoPlayer(url: selectVideoUrl, scaffoldKey: playerKey),
    );
  }

  Widget _buildDetailTopContainer(
      {BuildContext context, AnimationDetailItem detailItem}) {
    final double topHeight =
        MediaQuery.of(context).size.height * topContainerHeightRate;

    return Container(
      color: kBlack,
      height: topHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: double.infinity,
              margin: const EdgeInsets.all(10),
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
                          text:
                              "제작사 : ${detailItem.studioItems.map((studio) => studio.name).toString()}",
                          fontSize: 13,
                        ),
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
                            context: context, genres: detailItem.genres)
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

  Widget _buildDetailTopGenresContainer(
      {BuildContext context, List<AnimationDetailGenreItem> genres}) {
    final width = MediaQuery.of(context).size.width / 8 - 10;
    final List<AnimationDetailGenreItem> genreList =
        genres.length > 7 ? genres.sublist(0, 7) : genres;
    return genreList.length > 0 && genres.isNotEmpty
        ? Flexible(
            flex: 2,
            child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: genreList
                      .map((genre) => GestureDetector(
                            onTap: () {
                              // Navigator.pop(context, (router)=>true );
                              // BlocProvider.of<TabCubit>(context).tabUpdate(AppTab.GENRE);
                              // BlocProvider.of<GenreCategoryListBloc>(context).add(GenreItemClick(navItem: GenreNavItem()));
                            },
                            behavior: HitTestBehavior.translucent,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                width: width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: kWhite.withOpacity(0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: CustomText(
                                  fontColor: kWhite,
                                  fontSize: kAnimationDetailGenreFontSize,
                                  text: genre.name,
                                  isEllipsis: true,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                )))
        : Container();
  }

  Widget _buildDetailTopSynopsisContainer(
      {BuildContext context, AnimationDetailItem detailItem}) {
    return Column(
      children: [
        const TitleContainer(title: kAnimationDetailSynopsisTitle),
        Container(
          child: CustomText(
            fontSize: kAnimationDetailFontSize,
            text: detailItem.synopsis,
            fontColor: Colors.black,
          ),
          margin: const EdgeInsets.only(left: 10, top: 10),
        ),
      ],
    );
  }

  Widget _buildDetailTopImageContainer(
      {BuildContext context, AnimationDetailItem detailItem}) {
    final double topHeight =
        MediaQuery.of(context).size.height * topImageContainerHeightRate;
    final double imageItemWidth =
        MediaQuery.of(context).size.width * topImageWidthRate;

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
            padding: const EdgeInsets.all(20),
            width: imageItemWidth,
            height: topHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => imageAlert(context, detailItem.title, [detailItem.image], 0),
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

  Widget _buildTopCharacterContainer({List<CharacterItem> characters}) {
    return characters.isNotEmpty
        ? Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: _getPictureList(
                height: 200,
                margin: 10,
                length: characters.length,
                builderFunction: (BuildContext context, idx) {
                  final CharacterItem item = characters[idx];
                  double width = MediaQuery.of(context).size.width / 3;
                  return GestureDetector(
                    onTap: ()=>showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled:true,
                        context: context,
                        builder: (_) {
                          return BlocProvider(create: (_)=>CharacterBloc(repository: context.read<ApiRepository>())..add(CharacterLoad(characterId:item.characterId)), child: BottomCharacterItemContainer(),);
                        }),
                    child: Container(
                      padding: const EdgeInsets.only(left: 8, bottom: 8),
                      width: width,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Stack(
                              children: [
                                Container(
                                  child: ImageItem(
                                    imgRes: item.imageUrl,
                                    type: ImageShapeType.CIRCLE,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.topCenter,
                              margin: const EdgeInsets.only(top: 10),
                              child: CustomText(
                                fontWeight: FontWeight.w700,
                                fontColor: kBlack,
                                text: item.name,
                                maxLines: 2,
                                isDynamic: true,
                                isEllipsis: true,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        : EmptyContainer(
            title: "등장인물 정보 없음",
            size: 100,
          );
  }

  Widget _buildRelateContainer({List<RelatedAnimeItem> relatedItem}) {
    return relatedItem.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 10),
            child: _getPictureList(
                height: 200,
                margin: 10,
                length: relatedItem.length,
                builderFunction: (BuildContext context, idx) {
                  final RelatedAnimeItem item = relatedItem[idx];
                  return ImageTextScrollItemContainer(
                    context: context,
                    id: item.id.toString(),
                    title: item.title,
                    image: item.image,
                    imageShapeType: ImageShapeType.CIRCLE,
                    imageDiveRate: 3,
                    pushType: NavigationPushType.REPLACE,
                  );
                }),
          )
        : EmptyContainer(
            title: "관련 애니 없음",
            size: 100,
          );
  }

  Widget _buildRecommendationContainer(
      {List<RecommendationAnimeItem> recommendationItems}) {
    return recommendationItems.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: _getPictureList(
                height: 200,
                margin: 10,
                length: recommendationItems.length,
                builderFunction: (BuildContext context, idx) {
                  final RecommendationAnimeItem item = recommendationItems[idx];
                  return ImageTextScrollItemContainer(
                    context: context,
                    title: item.title,
                    id: item.id.toString(),
                    imageDiveRate: 3,
                    imageShapeType: ImageShapeType.CIRCLE,
                    image: item.image,
                    pushType: NavigationPushType.REPLACE,
                  );
                }),
          )
        : EmptyContainer(
            title: "추천 애니 없음",
            size: 100,
          );
  }

  Widget _buildLikeIndicator(
      {double height,
      String percent,
      String percentText,
      Color indicatorColor}) {
    return Container(
        margin: const EdgeInsets.only(top: 5, bottom: 10),
        alignment: AlignmentDirectional.bottomCenter,
        child: CircularPercentIndicator(
          radius: height,
          lineWidth: 8.0,
          animation: true,
          percent: double.parse(percent),
          center: CustomText(
            fontColor: kWhite,
            text: percentText,
            fontSize: kAnimationDetailIndicatorFontSize,
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: indicatorColor,
        ));
  }

  AppBar _buildAppbar(
      {String id,
      String type,
      AnimationDetailPageItem infoItem,
      BuildContext context,
      AnimationDetailItem detailItem}) {
    return AppBar(
        title: CustomText(
          fontFamily: doHyunFont,
          fontColor: kWhite,
          text: infoItem.title,
        ),
        actions: <Widget>[
          Visibility(
            visible: detailItem != null &&
                detailItem.videoItems != null &&
                detailItem.videoItems.length > 0,
            child: IconButton(
              icon: const Icon(Icons.video_collection),
              tooltip: "영상리스트",
              onPressed: () => {
                showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return BottomVideoItemContainer(
                        bloc: BlocProvider.of<AnimationDetailBloc>(context),
                        detailItem: detailItem,
                      );
                    })
              },
            ),
          ),
          PopupMenuButton<DeTailAnimationActions>(
            onSelected: (value) {
              switch (value) {
                case DeTailAnimationActions.ADD:
                  break;
                case DeTailAnimationActions.REFRESH:
                  BlocProvider.of<AnimationDetailBloc>(context)
                      .add(AnimationDetailLoad(id: id));
                  break;
              }
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuItem<DeTailAnimationActions>>[
              const PopupMenuItem<DeTailAnimationActions>(
                value: DeTailAnimationActions.ADD,
                child: Text('배치에 추가'),
              ),
              const PopupMenuItem<DeTailAnimationActions>(
                value: DeTailAnimationActions.REFRESH,
                child: Text('새로고침'),
              ),
            ],
          )
        ]);
  }

  Widget _buildTopContainerItem(
      {double fontSize,
      String text,
      FontWeight fontWeight = FontWeight.normal}) {
    return Flexible(
      flex: 1,
      child: Container(
          alignment: Alignment.center,
          child: CustomText(
            textAlign: TextAlign.center,
            text: text,
            fontSize: fontSize,
            fontColor: kWhite,
            fontFamily: doHyunFont,
            fontWeight: fontWeight,
            maxLines: 2,
            isEllipsis: true,
            isDynamic: true,
          )),
    );
  }

  Widget _getPictureList(
      {double height, double margin, int length, Function builderFunction}) {
    return Container(
      height: height,
      child: ListView.separated(
          padding: EdgeInsets.zero,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: margin,
            );
          },
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: length,
          shrinkWrap: true,
          itemBuilder: builderFunction),
    );
  }
}
