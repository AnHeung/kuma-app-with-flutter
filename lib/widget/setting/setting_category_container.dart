part of 'setting_widget.dart';

class SettingCategoryContainer extends StatelessWidget {
  final SettingConfig config;

  const SettingCategoryContainer({this.config});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      child: Row(
        children: [
          CustomText(
            text: "표시할 카테고리",
            fontSize: kSettingFontSize,
            fontColor: Colors.black,
          ),
          Expanded(
            flex: 1,
            child: LayoutBuilder(
              builder: (context,constraints){
                double margin = 20;
                double separatorWidth = 3;
                final double width = (constraints.maxWidth-margin)/kCategoryList.length - separatorWidth ;

                return Container(
                  margin: EdgeInsets.only(left: margin),
                  height: 30,
                  child: ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    separatorBuilder: (context, index) => SizedBox(
                      width: separatorWidth,
                    ),
                    itemBuilder: (ctx, idx) {
                      List<String> categoryKeyList = kCategoryList.keys.toList();
                      String categoryKey = categoryKeyList[idx];
                      String category = kCategoryList.values.toList()[idx];

                      return GestureDetector(
                          onTap: () {
                            String rankType = categoryKeyList
                                .reduce((acc, rankCategory) {
                              if (rankCategory == "upcoming") {
                                acc += ",$rankCategory";
                              } else if (!_isCheck(config.rankType, rankCategory) && rankCategory == categoryKey) {
                                acc += ",$rankCategory";
                              } else if (_isCheck(
                                  config.rankType, rankCategory) &&
                                  rankCategory != categoryKey) {
                                acc += ",$rankCategory";
                              }
                              return acc;
                            }) ?? "airing,upcoming";
                            BlocProvider.of<SettingBloc>(context).add(
                                ChangeSetting(
                                    config:
                                    config.copyWith(rankType: rankType)));
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            width: width,
                            decoration: BoxDecoration(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                                color: _isCheck(config.rankType, categoryKey)
                                    ? kPurple
                                    : kDisabled),
                            child: Container(
                                alignment: Alignment.center,
                                child: CustomText(
                                    fontFamily: doHyunFont,
                                    fontColor: kWhite,
                                    text: category,
                                    fontSize: 8.0,
                                    maxLines: 1,
                                    isEllipsis: true)),
                          ));
                    },
                    itemCount: kCategoryList.length,
                    scrollDirection: Axis.horizontal,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  _isCheck(String rankType, String key) => rankType.split(",").contains(key);
}
