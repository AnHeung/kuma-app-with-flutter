import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/news/animation_news_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_news_item.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<AnimationNewsBloc,AnimationNewsState>(
      builder: (context,state){
        return Scaffold(
          body: Center(
            child: ListView.builder(
              itemBuilder: (context,idx){
                final AnimationNewsItem newsItem = state.newsItems[idx];
                return Container(
                  width: double.infinity,
                  height: 100,
                  child: ImageItem(
                    type: ImageShapeType.FLAT,
                    imgRes: newsItem.imageUrl,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
