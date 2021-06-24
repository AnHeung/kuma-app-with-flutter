import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/animation_schedule/animation_schedule_bloc.dart';
import 'package:kuma_flutter_app/enums/base_bloc_state_status.dart';
import 'package:kuma_flutter_app/model/item/animation_schedule_item.dart';
import 'package:kuma_flutter_app/widget/animation_schedule/animation_schedule_widget.dart';
import 'package:kuma_flutter_app/widget/common/custom_text.dart';
import 'package:kuma_flutter_app/widget/common/loading_indicator.dart';


class AnimationScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheduleLayoutWidth = MediaQuery.of(context).size.width * 0.25;
    final Color bgColor = Colors.blueGrey[50];

    return BlocBuilder<AnimationScheduleBloc, AnimationScheduleState>(
      builder: (context, state) {
        List<AnimationScheduleItem> scheduleItems = state.scheduleItems;
        String currentDay = state.currentDay ?? "1";
        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            title: CustomText(
              text: kAnimationScheduleTitle,
              fontColor: kWhite,
              fontFamily: doHyunFont,
            ),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    Container(
                      height: double.infinity,
                      width: scheduleLayoutWidth,
                      child: AnimationScheduleIndicator(currentDay: currentDay),
                    ),
                    Expanded(child: _buildScheduleContainer(items: scheduleItems),)
                  ],
                ),
              ),
              LoadingIndicator(isVisible: state.status == BaseBlocStateStatus.Loading,)
            ],
          ),
        );
      },
    );
  }

  _buildScheduleContainer({List<AnimationScheduleItem> items}) {
    return Container(
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 10,
                );
              },
              padding: EdgeInsets.zero,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: items.length,
              itemBuilder: (context, idx) {
                final AnimationScheduleItem item = items[idx];
                return AnimationScheduleItemContainer(item: item);
              },
            ),
          );
  }
}
