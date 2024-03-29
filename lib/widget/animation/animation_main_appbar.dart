part of 'animation_widget.dart';

class AnimationMainAppbar extends StatefulWidget {

  @override
  _AnimationMainAppbarState createState() => _AnimationMainAppbarState();
}

class _AnimationMainAppbarState extends State<AnimationMainAppbar> {
  Timer timer;
  int currentPage = 0;
  final PageController controller = PageController(initialPage: 0, keepPage: false);
  int totalPageCount = 0;
  int scrollTime = 3;


  _disposeJob(){
    timer?.cancel();
    timer = null;
  }

  _resumeJob(){
    timer = timer ?? Timer.periodic(Duration(seconds: scrollTime), (timer) {
      if(controller.hasClients) {
        if (currentPage == totalPageCount) {
          controller?.animateToPage(0, duration:  const Duration(milliseconds: 600) , curve: Curves.easeOut);
          currentPage = 0;
        }else if (totalPageCount > 0) {
          controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnimationSeasonBloc, AnimationSeasonState>(
      listenWhen: (prev,cur)=>cur == BaseBlocStateStatus.Failure,
      listener: (context,state){
        String errMsg = state.msg;
        showToast(msg: errMsg);
      },
      builder: (context, seasonState) {
        if(seasonState.status ==  BaseBlocStateStatus.Success) {
          List<AnimationSeasonItem> list = seasonState.seasonItems;
          totalPageCount = list.length <= 0 ? 0 : list.length - 1;
          bool isAutoScroll = seasonState.isAutoScroll;
          if(isAutoScroll)_disposeJob();
          return FocusDetector(
            onFocusGained: isAutoScroll?_resumeJob: null,
            onFocusLost: isAutoScroll? _disposeJob : null,
            child: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: kWhite,
                    child: PageView(
                      onPageChanged: (page){
                        currentPage = controller.page.ceil();
                        _disposeJob();
                        _resumeJob();
                      },
                      controller: controller,
                      scrollDirection: Axis.horizontal,
                      children: list
                          .map((data) =>
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(
                                    context, Routes.IMAGE_DETAIL,
                                    arguments: AnimationDetailPageItem(
                                        id: data.id.toString(), title: data.title)),
                            child: _pageViewContainer(data),
                          ))
                          .toList(),
                    ),
                  ),
                  _indicatorWidget(context: context, indicatorSize: list.length)
                ],
              ),
            ),
          );
        }else if(seasonState.status ==  BaseBlocStateStatus.Loading){
          return LoadingIndicator(isVisible: seasonState == BaseBlocStateStatus.Loading,);
        }else if(seasonState.status == BaseBlocStateStatus.Failure){
          return RefreshContainer(callback: ()=>BlocProvider.of<AnimationSeasonBloc>(context).add(AnimationSeasonLoad(limit: kSeasonLimitCount)),);
        } else{
          return const EmptyContainer(title: kEmptyScreenDefaultMsg);

        }
      },
    );
  }

  Widget _pageViewContainer(AnimationSeasonItem item){

    return  Container(
      height: double.maxFinite,
      //// USE THIS FOR THE MATCH WIDTH AND HEIGHT
      width: double.maxFinite,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ImageItem(
            type: ImageShapeType.Flat,
            imgRes: item.image,
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 30 , left: 20),
            alignment: Alignment.bottomLeft,
            child: CustomText(
              fontColor: Colors.white,
              maxLines: 1,
              isEllipsis: true,
              fontFamily: doHyunFont,
              fontWeight: FontWeight.w700,
              fontSize:kAnimationTitleFontSize,
              text: item.title,
            ),
          ),
        ],
      ),
    );
  }

  Widget _indicatorWidget({BuildContext context, int indicatorSize}){
    return Container(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.1),
      alignment: Alignment.bottomCenter,
      child: Container(
        child: indicatorSize > 0
            ? SmoothPageIndicator(
          controller: controller,
          count: indicatorSize,
          effect: const WormEffect(dotWidth: 10, dotHeight: 10),
        )
            : const SizedBox(),
      ),
    );
  }
}
