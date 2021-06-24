part of 'account_widget.dart';

class AccountTitleContainer extends StatelessWidget {

  final String text;
  final bool isBold;
  final Color color;

  const AccountTitleContainer({this.text ="", this.isBold = false, this.color = kBlack});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
          left: 20,
        ),
        alignment: Alignment.centerLeft,
        height: kAccountItemHeight,
        child: CustomText(
          fontFamily: doHyunFont,
          text: text,
          fontWeight: isBold ? FontWeight.bold : null,
          fontColor: color,
          fontSize: kAccountFontSize,
        ));
  }
}
