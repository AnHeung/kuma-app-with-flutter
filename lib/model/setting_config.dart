import 'package:kuma_flutter_app/app_constants.dart';

class SettingConfig{

  final bool isAutoScroll;
  final String homeItemCount;
  final String rankType;

  SettingConfig({isAutoScroll, homeItemCount,rankType}): this.isAutoScroll = isAutoScroll ?? true, this.homeItemCount = homeItemCount?? kBaseHomeItemCount ,this.rankType = rankType ?? kBaseRankItem;

  SettingConfig copyWith({bool isAutoScroll ,String homeItemCount ,String rankType}){
    return SettingConfig(isAutoScroll:isAutoScroll ?? this.isAutoScroll , homeItemCount: homeItemCount ?? this.homeItemCount , rankType: rankType?? this.rankType );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'isAutoScroll': this.isAutoScroll,
      'homeItemCount': this.homeItemCount,
      'rankType': this.rankType,
    } as Map<String, dynamic>;
  }
}