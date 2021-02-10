import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation/animation_bloc.dart';
import 'package:kuma_flutter_app/main.dart';
import 'package:kuma_flutter_app/model/item/animation_main_item.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';

class AnimationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimationBloc, AnimationState>(
      builder: (context, state) {
        bool isLoading = state is AnimationLoadInProgress;
        final List<AnimationMainItem> mainItem  = (state is AnimationLoadSuccess) ? state.rankingList : null;

        return Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: Colors.blue,
                    child: Text('text'),
                  )
                ],
              ),
              LoadingIndicator(
                isVisible: isLoading,
              )
            ],
          ),
        );
      },
    );
  }
}
