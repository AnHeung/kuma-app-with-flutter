part of 'animation_widget.dart';

class AnimationScrollView extends StatefulWidget {
  @override
  _AnimationScrollViewState createState() => _AnimationScrollViewState();
}

class _AnimationScrollViewState extends State<AnimationScrollView> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> scrollOffset = ValueNotifier<double>(0.0);

  @override
  Widget build(BuildContext context) {
    return OffsetListenableProvider(
      offset: scrollOffset,
      child: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, isScrolled) {
          return [
            AnimationHomeSilverAppBar()
          ];
        },
        body: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const ClampingScrollPhysics(),
            children: [
              AnimationMainScheduleContainer(),
              _buildRankingItems(),
            ]),
      ),
    );
  }

  Widget _buildRankingItems() {
    return BlocBuilder<AnimationBloc, AnimationState>(
        builder: (context, state) {
          switch (state.status) {
            case BaseBlocStateStatus.Failure:
              return Container(
                height: 300,
                child: RefreshContainer(
                  callback: () =>
                      BlocProvider.of<AnimationBloc>(context).add(AnimationLoad()),
                ),
              );
            case BaseBlocStateStatus.Success:
              final List<AnimationMainItem> mainItemList = state.rankingList;
              return ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: mainItemList
                    .map((item) => _buildRankingItem(context, item))
                    .toList(),
              );
            default:
              return Container(
                height: 300,
                child: LoadingIndicator(
                  type: LoadingIndicatorType.IPhone,
                  isVisible: state.status == BaseBlocStateStatus.Loading ,
                ),
              );
          }
        });
  }

  Widget _buildRankingItem(BuildContext context, final AnimationMainItem item) {
    double heightSize = (MediaQuery.of(context).size.height) *
        kAnimationRankingContainerHeightRate;

    return Container(
      height: heightSize,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TitleContainer(
                fontWeight: FontWeight.w700, title: item.koreaType),
          ),
          Expanded(
            child: ListView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              children: item.list
                  .map(
                    (rankItem) => ImageTextScrollItemContainer(
                    imageShapeType: ImageShapeType.Flat,
                    imageDiveRate: 3,
                    context: context,
                    baseScrollItem: BaseScrollItem(
                      title: rankItem.title,
                      id: rankItem.id.toString(),
                      image: rankItem.image,
                      score: rankItem.score,
                      onTap: () => Navigator.pushNamed(
                        context,
                        Routes.IMAGE_DETAIL,
                        arguments: AnimationDetailPageItem(
                            id: rankItem.id, title: rankItem.title),
                      ),
                    )),
              )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (_scrollController.hasClients) {
      scrollOffset.value = _scrollController.offset;
    }
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }
}

class OffsetListenableProvider extends InheritedWidget {
  final ValueListenable<double> offset;

  OffsetListenableProvider({Key key, @required this.offset, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static ValueListenable<double> of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<OffsetListenableProvider>()
        .offset;
  }
}
