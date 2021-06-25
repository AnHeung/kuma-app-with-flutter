part of 'setting_widget.dart';

class SettingDropBoxContainer extends StatelessWidget {

  final SettingConfig config;
  const SettingDropBoxContainer({this.config});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  ChangeSetting(config: config.copyWith(homeItemCount: item)))
            },
            hint: config.homeItemCount,
          ),
        ],
      ),
    );
  }
}
