import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/search/search_bloc.dart';
import 'package:kuma_flutter_app/bloc/search_history/search_history_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_search_item.dart';
import 'package:kuma_flutter_app/model/item/base_scroll_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/util/common.dart';
import 'package:kuma_flutter_app/widget/common/inner_text_grid_container.dart';
import 'package:kuma_flutter_app/widget/common/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/search/search_app_bar.dart';
import 'package:kuma_flutter_app/widget/search/search_image_item.dart';

import '../model/item/animation_detail_page_item.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchHistoryBloc>(context).add(SearchHistoryLoad());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppbar(),
      body: Stack(
        children: <Widget>[
          _searchHistoryView(),
          _searchItemView(context),
          BlocBuilder<SearchBloc,SearchState>(builder: (context,state)=>LoadingIndicator(isVisible: state.status == SearchStatus.Loading,))
        ],
      ),
    );
  }

  _searchItemView(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context , state){
        if(state.status == SearchStatus.Failure) showToast(msg: state.msg);
      },
      builder: (context, state) {
        List<AnimationSearchItem> list = state.list;
        return Visibility(
          visible: list.isNotEmpty,
          child: Container(
            constraints: BoxConstraints(
                minHeight: 50,
                minWidth: double.infinity,
                maxHeight: MediaQuery.of(context).size.height * 0.6),
            color: kBlack,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: list
                  .map((searchItem) => SearchImageItem(
                        imgRes: searchItem.image,
                        title: searchItem.title,
                        onTap: () {
                          BlocProvider.of<SearchHistoryBloc>(context).add(SearchHistoryWrite(searchItem: AnimationSearchItem(id: searchItem.id, image: searchItem.image, title: searchItem.title)));
                          Navigator.pushNamed(context, Routes.IMAGE_DETAIL, arguments: AnimationDetailPageItem(id: searchItem.id.toString(), title: searchItem.title));
                        },
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  _searchHistoryView() {
    return BlocConsumer<SearchHistoryBloc, SearchHistoryState>(
      listener: (context,state){
        if(state.status == SearchStatus.Failure) showToast(msg: state.msg);
      },
      builder: (context, state) {
        List<AnimationSearchItem> searchHistoryList = state.list;
        return Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: InnerTextGridContainer(
                imageShapeType: ImageShapeType.Circle,
                gridCount: 3,
                list: searchHistoryList
                    .map((item) => BaseScrollItem(
                        id: item.id,
                        title: item.title,
                        image: item.image,
                        onTap: () {
                          BlocProvider.of<SearchHistoryBloc>(context).add(
                              SearchHistoryWrite(
                                  searchItem: AnimationSearchItem(
                                      id: item.id,
                                      image: item.image,
                                      title: item.title)));
                          Navigator.pushNamed(context, Routes.IMAGE_DETAIL,
                              arguments: AnimationDetailPageItem(
                                  id: item.id.toString(), title: item.title));
                        }))
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

