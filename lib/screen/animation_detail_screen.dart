part of 'screen.dart';

class AnimationDetailScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final AnimationDetailPageItem infoItem = ModalRoute.of(context).settings.arguments;
    final String id = infoItem.id;

    BlocProvider.of<AnimationDetailBloc>(context).add(AnimationDetailLoad(id: id));
    BlocProvider.of<SubscribeBloc>(context).add(CheckSubscribe(animationId: id));

    return BlocBuilder<AnimationDetailBloc, AnimationDetailState>(
      builder: (context, state) {
        final AnimationDetailItem detailItem = state.detailItem;
        bool isLoading = state.status == BaseBlocStateStatus.Loading;

        if (BaseBlocStateStatus.Failure == state.status) {
          showToast(msg: state.msg);
          return RefreshContainer(
              callback: () => BlocProvider.of<AnimationDetailBloc>(context)
                  .add(AnimationDetailLoad(id: id)));
        }

        return Scaffold(
          appBar: AnimationDetailAppbar(infoItem: infoItem, detailItem: state.detailItem),
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
            addAutomaticKeepAlives: true,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const ClampingScrollPhysics(),
            children: [
                AnimationDetailTopImageContainer(detailItem: detailItem),
                _buildDetailTopYoutubeContainer(
                    context: context,
                    selectVideoUrl: detailItem.selectVideoUrl),
                _buildDetailTopContainer(context: context, detailItem: detailItem),
                TitleImageMoreContainer(
                  onClick: () => moveToBottomMoreItemContainer(
                      title: kAnimationDetailCharacterTitle,
                      type: BottomMoreItemType.Character,
                      context: context,
                      items: detailItem.characterItems
                          .map((characterItem) => BottomMoreItem(
                              id: characterItem.characterId,
                              title: characterItem.name,
                              imgUrl: characterItem.imageUrl))
                          .toList()),
                  imageShapeType: ImageShapeType.Circle,
                  imageDiveRate: 3,
                  categoryTitle: kAnimationDetailCharacterTitle,
                  height: kAnimationImageContainerHeight,
                  baseItemList: detailItem.characterItems
                      .map((data) => BaseScrollItem(
                            id: data.characterId,
                            title: data.name,
                            image: data.imageUrl,
                            onTap: () => showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (_) {
                                  return BlocProvider(
                                    create: (_) => CharacterDetailBloc(
                                        repository:
                                            context.read<ApiRepository>())
                                      ..add(CharacterDetailLoad(
                                          characterId: data.characterId)),
                                    child: const BottomCharacterItemContainer(),
                                  );
                                }),
                          ))
                      .toList(),
                ),
                AnimationDetailSynopsisContainer(detailItem: detailItem),
                const TitleContainer(title: kAnimationDetailImageTitle),
                ImageScrollItemContainer(title: "관련 이미지", images: detailItem.pictures),
                TitleImageMoreContainer(
                  onClick: () => moveToBottomMoreItemContainer(
                      title: kAnimationDetailRelateTitle,
                      type: BottomMoreItemType.Animation,
                      context: context,
                      items: detailItem.relatedAnime
                          .map((characterItem) => BottomMoreItem(
                              id: characterItem.id,
                              title: characterItem.title,
                              imgUrl: characterItem.image))
                          .toList()),
                  categoryTitle: kAnimationDetailRelateTitle,
                  height: kAnimationImageContainerHeight,
                  imageDiveRate: 3,
                  imageShapeType: ImageShapeType.Circle,
                  baseItemList: detailItem.relatedAnime
                      .map((data) => BaseScrollItem(
                            id: data.id,
                            title: data.title,
                            image: data.image,
                            onTap: () => moveToAnimationDetailScreen(
                                context: context,
                                id: data.id,
                                title: data.title),
                          ))
                      .toList(),
                ),
                TitleImageMoreContainer(
                  onClick: () => moveToBottomMoreItemContainer(
                      type: BottomMoreItemType.Animation,
                      context: context,
                      items: detailItem.recommendationAnimes
                          .map((characterItem) => BottomMoreItem(
                              id: characterItem.id,
                              title: characterItem.title,
                              imgUrl: characterItem.image))
                          .toList()),
                  categoryTitle: kAnimationDetailRecommendTitle,
                  height: kAnimationImageContainerHeight,
                  imageDiveRate: 3,
                  imageShapeType: ImageShapeType.Circle,
                  baseItemList: detailItem.recommendationAnimes
                      .map((data) => BaseScrollItem(
                            id: data.id,
                            title: data.title,
                            image: data.image,
                            onTap: () => moveToAnimationDetailScreen(
                                context: context,
                                id: data.id,
                                title: data.title),
                          ))
                      .toList(),
                ),
              ])
        : const EmptyContainer(title: "",);
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
    final double topHeight = MediaQuery.of(context).size.height * kTopContainerHeightRate;

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
                        AnimationDetailTopItemContainer(
                            text: "${detailItem.title}",
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                        AnimationDetailTopItemContainer(
                            text: "(${detailItem.startSeason})",
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        AnimationDetailTopItemContainer(
                          text:
                              "제작사 : ${detailItem.studioItems.map((studio) => studio.name).toString()}",
                          fontSize: 13,
                        ),
                        AnimationDetailTopItemContainer(
                          text: detailItem.rank != null
                              ? '랭킹:${detailItem.rank}위'
                              : kAnimationDetailNoRanking,
                          fontSize: 13,
                        ),
                        AnimationDetailTopItemContainer(
                          text: '시즌 시작일:${detailItem.startDate}',
                          fontSize: 13,
                        ),
                        AnimationDetailTopItemContainer(
                          text: '시즌 종료일:${detailItem.endDate}',
                          fontSize: 13,
                        ),
                        AnimationDetailTopItemContainer(
                          text: detailItem.numEpisodes != "0"
                              ? '화수:${detailItem.numEpisodes}'
                              : kAnimationDetailNoEpisode,
                          fontSize: 13,
                        ),
                        AnimationDetailGenreContainer(genres: detailItem.genres)
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return AnimationDetailLikeIndicator(
                          height: constraints.maxHeight * kTopContainerIndicatorRate,
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
}
