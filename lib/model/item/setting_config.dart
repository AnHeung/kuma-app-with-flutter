import 'package:kuma_flutter_app/app_constants.dart';

class SettingConfig{

  final bool isAutoScroll;
  final bool receiveNotify;
  final String homeItemCount;
  final String rankType;

  SettingConfig({isAutoScroll, homeItemCount,rankType , receiveNotify}): this.isAutoScroll = isAutoScroll ?? true , this.receiveNotify = receiveNotify ?? true, this.homeItemCount = homeItemCount?? kBaseHomeItemCount ,this.rankType = rankType ?? kBaseRankItem;

  SettingConfig copyWith({bool isAutoScroll ,String homeItemCount ,String rankType , bool receiveNotify}){
    return SettingConfig(isAutoScroll:isAutoScroll ?? this.isAutoScroll ,receiveNotify: receiveNotify ?? this.receiveNotify, homeItemCount: homeItemCount ?? this.homeItemCount , rankType: rankType?? this.rankType );
  }

  Map<String, dynamic> toMap() {
    return {
      'isAutoScroll': this.isAutoScroll,
      'receiveNotify': this.receiveNotify,
      'homeItemCount': this.homeItemCount,
      'rankType': this.rankType,
    };
  }
}