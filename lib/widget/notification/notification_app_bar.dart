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
        text: kNotificationAppbarTitle,
        fontColor: kBlack,
        fontFamily: doHyunFont,
        fontSize: kAppbarTitleFontSize,
      ),
    );
  }
}



