import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation/animation_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_main_item.dart';
import 'package:kuma_flutter_app/widget/empty_container.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/rating_star_widget.dart';

class AnimationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimationBloc, AnimationState>(
      builder: (context, state) {
        bool isLoading = state is AnimationLoadInProgress;
        final List<AnimationMainItem> mainItemList =
            (state is AnimationLoadSuccess) ? state.rankingList : null;

        return Scaffold(
          body: Stack(
            children: [
              mainItemList != null
                  ? ListView(
                      children: mainItemList
                          .map((item) => _makeMainItem(context, item))
                          .toList(),
                    )
                  : EmptyContainer(),
              LoadingIndicator(
                isVisible: isLoading,
              )
            ],
          ),
        );
      },
    );
  }

  Color _setItemColor(String type) {
    Color color = Colors.grey;

    switch (type) {
      case "airing":
        color = Colors.blue;
        break;
      case "movie":
        color = Colors.grey;
        break;
      case "upcoming":
        color = Colors.greenAccent;
        break;
    }
    return color;
  }

  Widget _makeMainItem(BuildContext context, final AnimationMainItem item) {
    double heightSize = (MediaQuery.of(context).size.height) * 0.40;

    return Container(
      height: heightSize,
      padding: EdgeInsets.all(10),
      color: _setItemColor(item.type),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(item.type.toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: item.list
                  .map((rankItem) => _makeScrollItem(context, rankItem))
                  .toList(),
            ),
          ),
          Container()
        ],
      ),
    );
  }

  Widget _makeScrollItem(BuildContext context, final RankingItem item) {
    double width = MediaQuery.of(context).size.width / 3;

    return Container(
      padding: EdgeInsets.only(left: 8, bottom: 8),
      height: 50,
      width: width,
      child: Column(
        children: [
          Container(
            height: 30,
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              item.title,
              style: TextStyle(fontSize: 13, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: ImageItem(
                imgRes: item.image,
                type: ImageShapeType.FLAT,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
