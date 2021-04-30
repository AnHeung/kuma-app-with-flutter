import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/setting/setting_bloc.dart';
import 'package:kuma_flutter_app/model/setting_config.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/drop_down_button.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<SettingBloc>(context).add(SettingScreenExit());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('설정'),
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: BlocBuilder<SettingBloc, SettingState>(
                builder: (context, state) {
              SettingConfig config = state.config;
              return Stack(
                children: [
                  Column(
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
                            const Spacer(),
                            CustomDropDown(
                              value: config.homeItemCount,
                              items: itemCountList
                                  .map(
                                    (item) => DropdownMenuItem(
                                      child: CustomText(
                                        fontColor: kBlack,
                                        fontSize: 10.0,
                                        text: item.toString(),
                                        textAlign: TextAlign.center,
                                      ),
                                      value: item,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (item) => {
                                BlocProvider.of<SettingBloc>(context).add(
                                    ChangeSetting(
                                        config: config.copyWith(
                                            homeItemCount: item)))
                              },
                              hint: config.homeItemCount,
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
                            const SizedBox(
                              width: 50,
                            ),
                            Expanded(
                              flex: 1,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  print(categoryList.length);
                                  double width = constraints.maxWidth /
                                          categoryList.length -
                                      8;
                                  return Container(
                                    padding: EdgeInsets.zero,
                                    margin: const EdgeInsets.only(left: 20),
                                    height: 30,
                                    child: ListView.separated(
                                      physics: const ClampingScrollPhysics(),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
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
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(30)),
                                              color: _isCheck(config.rankType,
                                                      categoryKey)
                                                  ? kPurple
                                                  : kDisabled),
                                          child: GestureDetector(
                                              onTap: () {
                                                String rankType =
                                                    categoryKeyList.reduce((acc,
                                                            rankCategory) {
                                                          if (rankCategory ==
                                                              "upcoming") {
                                                            acc +=
                                                                ",$rankCategory";
                                                          } else if (!_isCheck(
                                                                  config
                                                                      .rankType,
                                                                  rankCategory) &&
                                                              rankCategory ==
                                                                  categoryKey) {
                                                            acc +=
                                                                ",$rankCategory";
                                                          } else if (_isCheck(
                                                                  config
                                                                      .rankType,
                                                                  rankCategory) &&
                                                              rankCategory !=
                                                                  categoryKey) {
                                                            acc +=
                                                                ",$rankCategory";
                                                          }
                                                          return acc;
                                                        }) ??
                                                        "airing,upcoming";
                                                BlocProvider.of<SettingBloc>(
                                                        context)
                                                    .add(ChangeSetting(
                                                        config: config.copyWith(
                                                            rankType:
                                                                rankType)));
                                              },
                                              behavior:
                                                  HitTestBehavior.translucent,
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
                            const Spacer(),
                            Container(
                              height: 30,
                              child: ToggleSwitch(
                                initialLabelIndex: config.isAutoScroll ? 0 : 1,
                                minWidth: 45.0,
                                cornerRadius: 10.0,
                                activeBgColor: kPurple,
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  LoadingIndicator(
                    isVisible: state.status == SettingStatus.loading,
                  )
                ],
              );
            })),
      ),
    );
  }

  _isCheck(String rankType, String key) => rankType.split(",").contains(key);
}
