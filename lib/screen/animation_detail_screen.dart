import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation/animation_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation_detail/animation_detail_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_detail_item.dart';
import 'package:kuma_flutter_app/model/item/animation_main_item.dart';
import 'package:kuma_flutter_app/widget/empty_container.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';


class AnimationDetailScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final RankingItem infoItem = ModalRoute.of(context).settings.arguments;
    String id = infoItem.id.toString();
    String type = "all";

    BlocProvider.of<AnimationDetailBloc>(context).add(AnimationDetailLoad(id: id, type: type));

    return BlocBuilder<AnimationDetailBloc, AnimationDetailState>(
      builder: (context, state) {
        bool isLoading = state is AnimationDetailLoadInProgress;
        final AnimationDetailItem detailItem = (state is AnimationDetailLoadSuccess)? state.detailItem  : null;

        return Scaffold(
          appBar: AppBar(
            title: Text(infoItem.title, style: TextStyle(fontSize: 15),),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                tooltip: "설정" ,
                onPressed: ()=>{
                  BlocProvider.of<AnimationDetailBloc>(context).add(AnimationDetailLoad(id: id, type: type))
                },
              ),
            ],
          ),
          body: Stack(
            children: [
              detailItem != null ? Stack(
                children: [
                   Scaffold(
                      backgroundColor: Colors.transparent,
                    ),
                  Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: ImageItem(
                          imgRes: detailItem.image,
                          type: ImageShapeType.FLAT,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [

                        ],
                      ),
                    )
                  ],
                ),
              ]): EmptyContainer(),
              LoadingIndicator(isVisible: isLoading,)
            ],
          ),
        );
      },
    );
  }
}
