import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/account/account_bloc.dart';
import 'package:kuma_flutter_app/bloc/auth/auth_bloc.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/enums/image_type.dart';
import 'package:kuma_flutter_app/model/api/social_user.dart';
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

    return BlocListener<AuthBloc,AuthState>(
        listener: (context,state){
          if(state.status == AuthStatus.UnAuth) Navigator.pushNamedAndRemoveUntil(context, Routes.HOME, (route) => false);
        },
      child: Scaffold(
          appBar: AppBar(
            title: Text('계정 설정'),
          ),
          body: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if (state is AccountLoadInProgress) {
                return LoadingIndicator(
                  isVisible: state is AccountLoadInProgress,
                );
              } else if (state is AccountLoadSuccess) {
                UserAccount accountData = state.accountData;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 20, top: 15),
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: '닉네임',
                          fontColor: Colors.grey,
                          fontSize: 13,
                        )),
                    Container(
                        padding: EdgeInsets.only(
                          left: 20,
                        ),
                        alignment: Alignment.centerLeft,
                        height: 40,
                        child: CustomText(
                          text: accountData.userName,
                          fontColor: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    Container(
                        padding: EdgeInsets.only(
                          left: 20,
                        ),
                        alignment: Alignment.centerLeft,
                        color: Colors.black12,
                        height: 40,
                        width: double.infinity,
                        child: CustomText(
                          text: '계정',
                          fontColor: Colors.black,
                          fontSize: 15,
                        )),
                    Container(
                        padding: EdgeInsets.only(left: 20, top: 15),
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: '이메일',
                          fontColor: Colors.grey,
                          fontSize: 13,
                        )),
                    Container(
                        padding: EdgeInsets.only(
                          left: 20,
                        ),
                        alignment: Alignment.centerLeft,
                        height: 50,
                        child: CustomText(
                          text: accountData.email,
                          fontColor: Colors.black,
                          fontSize: 15,
                        )),
                    Container(
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      alignment: Alignment.centerLeft,
                      color: Colors.black12,
                      height: 50,
                      width: double.infinity,
                      child: Text('로그인 타입'),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 20, top: 15),
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: accountData.loginType,
                          fontColor: Colors.grey,
                          fontSize: 13,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            child: ImageItem(
                              type: ImageShapeType.CIRCLE,
                              imgRes: accountData.socialType.iconRes,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                left: 20,
                              ),
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: CustomText(
                                text: enumToString(accountData.socialType),
                                fontColor: Colors.black,
                                fontSize: 15,
                              ))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      alignment: Alignment.centerLeft,
                      color: Colors.black12,
                      height: 50,
                      width: double.infinity,
                      child: Text('계정탈퇴 및 초기화'),
                    ),
                    GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => showBaseDialog(context: context, confirmFunction: (){
                          BlocProvider.of<AccountBloc>(context).add(AccountWithdraw());
                          Navigator.pop(context);
                        } ,title: "회원탈퇴",content: "회원탈퇴를 하시겠습니까?"),
                        child: Container(
                            padding: EdgeInsets.only(
                              left: 20,
                            ),
                            alignment: Alignment.centerLeft,
                            height: 50,
                            child: CustomText(
                              text: '탈퇴하기',
                              fontColor: Colors.black,
                              fontSize: 15,
                            ))),
                  ],
                );
              } else if (state is AccountLoadFailure) {
                return RefreshContainer(
                  callback: () =>
                      BlocProvider.of<AccountBloc>(context).add(AccountLoad()),
                );
              }
              return EmptyContainer(
                title: "로딩 안됨.",
              );
            },
          )),
    );
  }

  _accountContainer() {}
}
