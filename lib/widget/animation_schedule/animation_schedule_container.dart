part of 'animation_schedule_widget.dart';

class AnimationScheduleContainer extends StatelessWidget {

  final List<AnimationScheduleItem> items;

  const AnimationScheduleContainer({this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        separatorBuilder: separatorBuilder(context: context,),
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
