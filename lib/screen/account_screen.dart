import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/account/account_bloc.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/user_account.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/util/string_util.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/empty_container.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/refresh_container.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('계정 설정'),
        ),
        body: BlocConsumer<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state.status == AccountStatus.failure) {
              showToast(msg: state.msg);
            } else if (state.status == AccountStatus.withdraw) {
              showToast(msg: state.msg);
              Navigator.pushNamedAndRemoveUntil(context, Routes.HOME, (route) => false);
            }
          },
          builder: (context, state) {
            if (state.status == AccountStatus.loading) {
              return LoadingIndicator(
                isVisible: state.status == AccountStatus.loading,
              );
            } else if (state.status == AccountStatus.success) {
              UserAccount accountData = state.accountData;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      alignment: Alignment.centerLeft,
                      color: Colors.black12,
                      height: kAccountItemHeight,
                      width: double.infinity,
                      child: CustomText(
                        fontFamily: doHyunFont,
                        text: '계정',
                        fontColor: Colors.black,
                        fontSize: kAccountFontSize,
                      )),
                  Container(
                      height: kAccountItemHeight,
                      padding: const EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        fontFamily: doHyunFont,
                        text: '닉네임',
                        fontColor: Colors.grey,
                        fontSize: kAccountFontSize,
                      )),
                  Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      alignment: Alignment.centerLeft,
                      height: kAccountItemHeight,
                      child: CustomText(
                        fontFamily: doHyunFont,
                        text: accountData.userName,
                        fontColor: kBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: kAccountTitleFontSize,
                      )),
                  Container(
                      height: kAccountItemHeight,
                      padding: const EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        fontFamily: doHyunFont,
                        text: '이메일',
                        fontColor: Colors.grey,
                        fontSize: kAccountFontSize,
                      )),
                  Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      alignment: Alignment.centerLeft,
                      height: kAccountItemHeight,
                      child: CustomText(
                        fontFamily: doHyunFont,
                        text: accountData.userId,
                        fontColor: Colors.black,
                        fontSize: kAccountFontSize,
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    alignment: Alignment.centerLeft,
                    color: Colors.black12,
                    height: kAccountItemHeight,
                    width: double.infinity,
                    child: CustomText(
                      fontFamily: doHyunFont,
                      text: '로그인 타입',
                      fontColor: kBlack,
                      fontSize: kAccountFontSize,
                    ),
                  ),
                  Container(
                      height: kAccountItemHeight,
                      padding: const EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        fontFamily: doHyunFont,
                        text: (accountData.loginType != LoginType.UNKNOWN &&
                                accountData.loginType != LoginType.EMAIL)
                            ? "소셜"
                            : "이메일",
                        fontColor: Colors.grey,
                        fontSize: kAccountFontSize,
                      )),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            child: ImageItem(
                              type: ImageShapeType.CIRCLE,
                              imgRes: accountData.loginType.iconRes,
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              alignment: Alignment.centerLeft,
                              height: kAccountItemHeight,
                              child: CustomText(
                                fontFamily: doHyunFont,
                                text: enumToString(accountData.loginType),
                                fontColor: Colors.black,
                                fontSize: kAccountFontSize,
                              ))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    alignment: Alignment.centerLeft,
                    color: Colors.black12,
                    height: kAccountItemHeight,
                    width: double.infinity,
                    child: const Text('계정탈퇴 및 초기화'),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: ()=>{
                      showBaseDialog(context: context, confirmFunction: (){
                        BlocProvider.of<AccountBloc>(context).add(AccountWithdraw(userId: accountData.userId));
                        Navigator.pop(context);
                      } ,title: "회원탈퇴",content: "회원탈퇴를 하시겠습니까?")
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
                            text: '탈퇴하기',
                            fontColor: kWhite,
                          ),
                        )),
                  )
                ],
              );
            }
            return RefreshContainer(
              callback: () =>
                  BlocProvider.of<AccountBloc>(context).add(AccountLoad()),
            );
          },
        ));
  }
}
