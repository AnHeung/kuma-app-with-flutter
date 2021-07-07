part of 'setting_widget.dart';

class SettingDropBoxContainer extends StatelessWidget {

  final SettingConfig config;
  const SettingDropBoxContainer({this.config});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSettingContainerHeight,
      child: Row(
        children: [
          CustomText(
            text: kSettingHomeItemTitle,
            fontSize: kSettingFontSize,
            fontColor: Colors.black,
          ),
          const Spacer(),
          CustomDropDown(
            value: config.homeItemCount,
            items: kSettingHomeItemCountList
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
