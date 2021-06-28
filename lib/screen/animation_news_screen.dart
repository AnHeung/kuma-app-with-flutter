part of 'screen.dart';

class AnimationNewsScreen extends StatelessWidget {
  final String initialPage = "1";

  @override
  Widget build(BuildContext context) {

    String currentQuery = "";
    return Scaffold(
      appBar: NewsSearchAppbar(
        queryCallback: (query) {
          currentQuery = query;
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => BlocProvider.of<AnimationNewsBloc>(context)
            .add(AnimationNewsScrollToTop()),
        child: const Icon(Icons.arrow_circle_up_outlined),
      ),
      backgroundColor: kWhite,
      body: RefreshIndicator(
          onRefresh: () async => {
                BlocProvider.of<AnimationNewsBloc>(context).add(
                    AnimationNewsLoad(query: currentQuery, page: initialPage))
              },
          child: BlocBuilder<AnimationNewsBloc, AnimationNewsState>(
              builder: (context, state) {
            if (state.status == AnimationNewsStatus.Failure) {
              showToast(msg: state.msg);
              return RefreshContainer(
                callback: () => BlocProvider.of<AnimationNewsBloc>(context)
                    .add(AnimationNewsLoad(page: initialPage)),
              );
            }
            return NewsScrollContainer(
              onLoadMore: (page) {
                BlocProvider.of<AnimationNewsBloc>(context).add(
                    AnimationNewsLoad(
                        page: page.toString(), query: currentQuery));
              },
              state: state,
            );
          })),
    );
  }
}
