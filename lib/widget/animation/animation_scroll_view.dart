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
              AnimationMainRankContainer(),
            ]),
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
