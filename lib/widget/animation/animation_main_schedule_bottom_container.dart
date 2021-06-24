part of 'animation_widget.dart';

class AnimationMainScheduleBottomContainer extends StatelessWidget {

  final List<AnimationScheduleItem> scheduleItems;

  const AnimationMainScheduleBottomContainer({this.scheduleItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: const EdgeInsets.only(top: 10),
      child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          children: scheduleItems
              .map(
                (schedule) => ImageTextScrollItemContainer(
                context: context,
                imageShapeType: ImageShapeType.Flat,
                imageDiveRate: 4,
                baseScrollItem: BaseScrollItem(
                  onTap: () => Navigator.pushNamed(
                      context, Routes.IMAGE_DETAIL,
                      arguments: AnimationDetailPageItem(
                          id: schedule.id, title: schedule.title)),
                  image: schedule.image,
                  id: schedule.id.toString(),
                  title: schedule.title,
                )),
          )
              .toList()),
    );
  }
}
