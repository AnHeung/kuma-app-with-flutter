part of 'screen.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppbar(),
      body: Stack(
        children: <Widget>[
            SearchHistoryContainer(),
            SearchItemContainer(),
          BlocBuilder<SearchBloc,SearchState>(builder: (context,state)=>LoadingIndicator(isVisible: state.status == SearchStatus.Loading,))
        ],
      ),
    );
  }
}

