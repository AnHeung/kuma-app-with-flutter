part of 'animation_widget.dart';

class AnimationNotificationIcon extends StatelessWidget {

  final String unReadCount;
  final Color appIconColors;

  const AnimationNotificationIcon({this.unReadCount,this.appIconColors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 30,
      height: 30,
      child: Stack(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            color: Colors.white,
            icon: Icon(
              Icons.notifications_none,
              color: appIconColors,
              size: 30,
            ),
            tooltip: "알림",
            onPressed: () {
              BlocProvider.of<NotificationBloc>(context)
                  .add(NotificationLoad());
              Navigator.pushNamed(
                  context, Routes.Notification);
            },
          ),
          Visibility(
              visible: unReadCount != "0",
              child:  Container(
                width: 30,
                height: 30,
                alignment: Alignment.topRight,
                margin: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xffc32c37),
                      border: Border.all(color: Colors.white, width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                      child: Text(unReadCount,
                        style: const TextStyle(fontSize: 7),
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
