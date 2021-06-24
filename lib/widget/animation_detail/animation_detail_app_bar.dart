part of 'animation_detail_widget.dart';

class AnimationDetailAppbar extends BaseAppbar {

  final AnimationDetailPageItem infoItem;
  final AnimationDetailItem detailItem;

  const AnimationDetailAppbar({this.infoItem, this.detailItem});

  @override
  _AnimationDetailAppbarState createState() => _AnimationDetailAppbarState();
}

class _AnimationDetailAppbarState extends State<AnimationDetailAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: CustomText(
          fontFamily: doHyunFont,
          fontColor: kWhite,
          text: widget.infoItem.title,
        ),
        actions: <Widget>[
          BlocConsumer<SubscribeBloc, SubscribeState>(
            listener: (context, state) {
              if (state.status == BaseBlocStateStatus.Failure)
                print(state.msg);
            },
            builder: (context, state) {
              bool isLogin = state.isLogin;
              bool isSubscribe = state.isSubscribe;
              return Visibility(
                visible: isLogin && widget.detailItem.isNotNull,
                child: IconButton(
                  color: isSubscribe ? Colors.red : kWhite,
                  icon: isSubscribe
                      ? const Icon(Icons.notifications_on)
                      : const Icon(Icons.notifications_on_outlined),
                  tooltip: "알림",
                  onPressed: () =>
                  {
                    showBaseDialog(context: context,
                        title: "구독알림",
                        content: isSubscribe
                            ? "구독해지 하시겠습니까?"
                            : "구독하시겠습니까? 구독하면 해당 애니메이션 관련 알림이 날라옵니다.",
                        confirmFunction: () {
                          BlocProvider.of<SubscribeBloc>(context).add(
                              SubscribeUpdate(item: SubscribeItem(
                                  mainTitle: widget.detailItem.titleEn,
                                  animationId: widget.detailItem.id,
                                  thumbnail: widget.detailItem.image),
                                  isSubScribe: !isSubscribe));
                          Navigator.pop(context);
                        })},
                ),
              );
            },
          ),
          Visibility(
            visible: widget.detailItem.isNotNull &&
                !widget.detailItem.videoItems.isNullOrEmpty,
            child: IconButton(
              icon: const Icon(Icons.play_circle_outline),
              tooltip: "영상리스트",
              onPressed: () =>
              {
                showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return BottomVideoItemContainer(
                        bloc: BlocProvider.of<AnimationDetailBloc>(context),
                        detailItem: widget.detailItem,
                      );
                    })
              },
            ),
          ),
          PopupMenuButton<DetailAnimationActions>(
            onSelected: (value) {
              switch (value) {
                case DetailAnimationActions.Add:
                  break;
                case DetailAnimationActions.Refresh:
                  BlocProvider.of<AnimationDetailBloc>(context)
                      .add(AnimationDetailLoad(id: widget.infoItem.id));
                  break;
              }
            },
            itemBuilder: (BuildContext context) =>
            <PopupMenuItem<DetailAnimationActions>>[
              const PopupMenuItem<DetailAnimationActions>(
                value: DetailAnimationActions.Add,
                child: Text('배치에 추가'),
              ),
              const PopupMenuItem<DetailAnimationActions>(
                value: DetailAnimationActions.Refresh,
                child: Text('새로고침'),
              ),
            ],
          )
        ]);
  }
}
