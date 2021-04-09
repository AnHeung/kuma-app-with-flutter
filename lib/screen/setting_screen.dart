import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/setting/setting_bloc.dart';
import 'package:kuma_flutter_app/model/setting_config.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/drop_down_button.dart';
import 'package:kuma_flutter_app/widget/empty_container.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SettingBloc>(context).add(SettingLoad());

    SettingConfig config = SettingConfig.empty;

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<SettingBloc>(context).add(SettingScreenExit());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('설정'),
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: BlocBuilder<SettingBloc, SettingState>(
              builder: (context, state) {
                if (state is SettingLoadingInProgress) {
                  LoadingIndicator(
                    isVisible: state is SettingLoadingInProgress,
                  );
                } else if (state is SettingLoadSuccess) {
                  config = state.config;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        child: Row(
                          children: [
                            CustomText(
                              text: "홈화면에 보여줄 아이템 갯수",
                              fontSize: kSettingFontSize,
                              fontColor: Colors.black,
                            ),
                            Spacer(),
                            CustomDropDown(
                              value: config.aniLoadItemCount,
                              items: itemCountList
                                  .map((item) => DropdownMenuItem(
                                  child: CustomText(
                                    fontColor: kBlack,
                                    fontSize: 12.0,
                                    text: item.toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                  value: item,
                                ),
                              )
                                  .toList(),
                              onChanged: (item) => {
                                BlocProvider.of<SettingBloc>(context).add(ChangeSetting(config: config.copyWith(aniLoadItemCount: item)))
                              },
                              hint: config.aniLoadItemCount,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 70,
                        child: Row(
                          children: [
                            CustomText(
                              text: "표시할 카테고리",
                              fontSize: kSettingFontSize,
                              fontColor: Colors.black,
                            ),
                            SizedBox(width: 50,),
                            Expanded(
                              flex: 1,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  print(categoryList.length);
                                  double width = constraints.maxWidth / categoryList.length - 7;
                                  return Container(
                                    margin: EdgeInsets.only(left: 20),
                                    height: 40,
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            width: 3,
                                          ),
                                      itemBuilder: (context, idx) {
                                        List<String> categoryKeyList =
                                        categoryList.keys.toList();
                                        String categoryKey =
                                        categoryKeyList[idx];
                                        String category =
                                        categoryList.values.toList()[idx];

                                        return Container(
                                          width: width,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              color: _isCheck(
                                                  config.rankingType,
                                                  categoryKey)
                                                  ? kBlue
                                                  : kDisabled),
                                          child: GestureDetector(
                                              onTap: () {
                                                String rankType = categoryKeyList.reduce((acc, rankCategory) {
                                                  if (rankCategory == "upcoming") {
                                                    acc += ",$rankCategory";
                                                  } else if (!_isCheck(config.rankingType, rankCategory) && rankCategory == categoryKey) {
                                                    acc += ",$rankCategory";
                                                  } else if (_isCheck(config.rankingType, rankCategory) && rankCategory != categoryKey) {
                                                    acc += ",$rankCategory";
                                                  }
                                                  return acc;
                                                }) ?? "airing,upcoming";
                                                BlocProvider.of<SettingBloc>(
                                                    context)
                                                    .add(ChangeSetting(
                                                    config: config.copyWith(
                                                        rankingType:
                                                        rankType)));
                                              },
                                              behavior: HitTestBehavior.translucent,
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  child: CustomText(
                                                    fontFamily: doHyunFont,
                                                    fontColor: kWhite,
                                                      text: category,
                                                      fontSize: 8.0,
                                                      maxLines: 1,
                                                      isEllipsis: true))),
                                        );
                                      },
                                      itemCount: categoryList.length,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 70,
                        child: Row(
                          children: [
                            CustomText(
                              text: "홈화면 자동 스크롤",
                              fontSize: kSettingFontSize,
                              fontColor: Colors.black,
                            ),
                            Spacer(),
                            ToggleSwitch(
                              initialLabelIndex: config.isAutoScroll ? 0 : 1,
                              minWidth: 50.0,
                              cornerRadius: 10.0,
                              activeBgColor: kBlue,
                              activeFgColor: Colors.white,
                              inactiveBgColor: kDisabled,
                              inactiveFgColor: Colors.white,
                              labels: ['', ''],
                              icons: [
                                FontAwesomeIcons.check,
                                FontAwesomeIcons.times
                              ],
                              onToggle: (index) {
                                print("index $index");
                                BlocProvider.of<SettingBloc>(context).add(
                                    ChangeSetting(
                                        config: config.copyWith(
                                            isAutoScroll: index == 0)));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return EmptyContainer(
                  title: "설정값 불러오기 실패",
                );
              },
            )),
      ),);
  }

  _isCheck(String rankType, String key) => rankType.split(",").contains(key);
}
