part of 'screen.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomText(text:'계정 설정', fontSize: 15.0, fontColor: kWhite,),
        ),
        body: BlocConsumer<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state.status == AccountStatus.Failure) {
              showToast(msg: state.msg);
              Navigator.pop(context);
            } else if (state.status == AccountStatus.Withdraw) {
              showToast(msg: state.msg);
              moveToHomeScreen(context:context);
            }
          },
          builder: (context, state) {
            if (state.status == AccountStatus.Loading) {
              return LoadingIndicator(
                isVisible: state.status == AccountStatus.Loading,
              );
            } else if (state.status == AccountStatus.Success) {
              UserAccount accountData = state.accountData;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const AccountSubjectContainer(title: "계정"),
                  const AccountTitleContainer(isBold: false, text: "닉네임" , color: kGrey),
                  AccountTitleContainer(isBold: true, text: accountData.userName , color: kBlue),
                  const AccountTitleContainer(isBold: false, text: '이메일' , color: kGrey),
                  AccountTitleContainer(isBold: true, text: accountData.userId , color: kBlack),
                  const AccountSubjectContainer(title: "로그인 타입"),
                  AccountTitleContainer(isBold: false, text: (accountData.loginType != LoginType.UNKNOWN &&
                      accountData.loginType != LoginType.EMAIL)
                      ? "소셜"
                      : "이메일" , color: kGrey),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            child: ImageItem(
                              type: ImageShapeType.Circle,
                              imgRes: accountData.loginType.iconRes,
                            ),
                          ),
                          AccountTitleContainer(isBold: true, text: enumToString(accountData.loginType) , color: kBlack),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  AccountWithdrawButton(userId: accountData.userId)
                ],
              );
            }
            return const EmptyContainer(
              title: "정보가 없습니다.",
            );
          },
        ));
  }
}
