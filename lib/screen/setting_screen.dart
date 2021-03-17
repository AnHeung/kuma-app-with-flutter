import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    List<String> itemCountList = [
      "5",
      "10",
      "15",
      "20",
      "25",
      "30",
      "35",
      "40",
      "45",
      "50"
    ];
    Map<String,String> categoryList = {"airing":"상영중","upcoming":"상영예정","movie":"극장판","ova":"OVA","tv":"TV"};

    SettingConfig config = SettingConfig.empty;

    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
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
                            fontSize: 20,
                            fontColor: Colors.black,
                          ),
                          Spacer(),
                          CustomDropDown(
                            value: config.aniLoadItemCount,
                            items: itemCountList
                                .map(
                                  (item) => DropdownMenuItem(
                                    child: Text(
                                      item.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                    value: item,
                                  ),
                                )
                                .toList(),
                            onChanged: (item) => {
                              BlocProvider.of<SettingBloc>(context).add(
                                  SettingChange(
                                      config: config.copyWith(
                                          aniLoadItemCount: item)))
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
                            fontSize: 20,
                            fontColor: Colors.black,
                          ),
                        Expanded(
                          flex: 1,
                          child: LayoutBuilder(builder: (context, constraints){
                                double width = constraints.maxWidth/categoryList.length-5;
                                print(width);
                                return Container(
                                  margin: EdgeInsets.only(left: 10),
                                    height: 40,
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) =>SizedBox(width: 3,),
                                      itemBuilder: (context, idx) {

                                        String key =  categoryList.keys.toList()[idx];
                                        String category = categoryList.values.toList()[idx];
                                        var isCheck =  config.rankingType.split(",").contains(key) || config.rankingType.contains("all");

                                        return Container(
                                          width: width,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)) , color: isCheck
                                              ? Colors.blue
                                              : Colors.grey),
                                          child: GestureDetector(onTap: (){
                                            String rankType = categoryList.keys.toList().reduce((acc, category){
                                              if((isCheck && category != key)||(!isCheck && category == key)){
                                                acc += ",$category";
                                              }
                                              return acc;
                                            }) ?? "all";
                                            print(rankType);
                                            BlocProvider.of<SettingBloc>(context).add(SettingChange(config: config.copyWith(rankingType: rankType)));
                                          } , behavior: HitTestBehavior.translucent, child: Container(alignment:Alignment.center,child: CustomText(text:category , maxLines: 1, isEllipsis: true))),
                                        );
                                      },
                                      itemCount: categoryList.length,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  );
                              },),
                        )
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Row(
                        children: [
                          CustomText(
                            text: "홈화면 자동 스크롤",
                            fontSize: 20,
                            fontColor: Colors.black,
                          ),
                          Spacer(),
                          ToggleSwitch(
                            initialLabelIndex: config.isAutoScroll ? 0 : 1,
                            minWidth: 50.0,
                            cornerRadius: 10.0,
                            activeBgColor: Colors.cyan,
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.grey,
                            inactiveFgColor: Colors.white,
                            labels: ['', ''],
                            icons: [
                              FontAwesomeIcons.check,
                              FontAwesomeIcons.times
                            ],
                            onToggle: (index) {
                              BlocProvider.of<SettingBloc>(context).add(
                                  SettingChange(
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
    );
  }
}
