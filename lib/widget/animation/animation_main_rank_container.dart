part of 'animation_widget.dart';

class AnimationMainRankContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    .map((item) => AnimationMainRankItemContainer(item:item))
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
}
