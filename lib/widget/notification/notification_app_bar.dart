part of 'notification_widget.dart';

class NotificationAppbar extends BaseAppbar{
  @override
  State<StatefulWidget> createState() =>_NotificationAppbarState();
}

class _NotificationAppbarState extends State<NotificationAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: kWhite,
      elevation: 0,
      centerTitle: true,
      title: CustomText(
        text: '알림내역',
        fontColor: kBlack,
        fontFamily: doHyunFont,
        fontSize: 20.0,
      ),
    );
  }
}



