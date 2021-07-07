part of 'account_widget.dart';

class AccountWithdrawButton extends StatelessWidget {

  final String userId;
  const AccountWithdrawButton({this.userId});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: ()=>{
        showBaseDialog(context: context, confirmFunction: (){
          BlocProvider.of<AccountBloc>(context).add(AccountWithdraw(userId: userId));
          Navigator.pop(context);
        } ,title: kAccountWithdrawTitle,content: kAccountWithdrawInfoMsg)
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
          color: Colors.red,
          alignment: Alignment.bottomCenter,
          height: kAccountWithdrawBtnHeight,
          child: Align(
            alignment: Alignment.center,
            child: CustomText(
              fontFamily: doHyunFont,
              text: kAccountWithdrawButtonTitle,
              fontColor: kWhite,
            ),
          )),
    );
  }
}
