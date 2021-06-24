part of 'account_widget.dart';

class AccountSubjectContainer extends StatelessWidget {

  final String title;

  const AccountSubjectContainer({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
          left: 20,
        ),
        alignment: Alignment.centerLeft,
        color: kDisabled,
        height: kAccountItemHeight,
        width: double.infinity,
        child: CustomText(
          fontFamily: doHyunFont,
          text: title,
          fontColor: Colors.black,
          fontSize: kAccountFontSize,
        ));
  }
}
