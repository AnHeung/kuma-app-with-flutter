import 'package:kuma_flutter_app/app_constants.dart';

class FirebaseUserItem {

  final String userId;
  final bool isAutoScroll;
  final String homeItemCount;
  final String rankType;
  final String userName;
  final String loginType;

  const FirebaseUserItem({userId, isAutoScroll, homeItemCount, rankType ,userName, loginType}) : this.userId = userId ?? "" , this.isAutoScroll  = isAutoScroll ?? true, this.homeItemCount = homeItemCount ?? kBaseHomeItemCount
  , this.userName = userName ?? "" , this.loginType = loginType ?? "EMAIL" , this.rankType = rankType ?? kBaseRankItem;

  FirebaseUserItem copyWith({String userId, String isAutoScroll, String homeItemCount, String rankType ,String userName, String loginType}){
    return FirebaseUserItem(loginType: loginType?? this.loginType , userId: userId ?? this.userId, homeItemCount: homeItemCount ?? this.homeItemCount,
        rankType: rankType ?? this.rankType , isAutoScroll: isAutoScroll ?? this.isAutoScroll ,userName: userName?? this.userName);
  }
}