part of 'setting_widget.dart';

class SettingCheckBoxContainer extends StatelessWidget {

  final String title;
  final bool initialValue;
  final OnToggle onToggle;

  const SettingCheckBoxContainer({this.title, this.initialValue, this.onToggle});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSettingContainerHeight,
      child: Row(
        children: [
          CustomText(
            text: title,
            fontSize: kSettingFontSize,
            fontColor: Colors.black,
          ),
          const Spacer(),
          Container(
            height: 30,
            child: ToggleSwitch(
              initialLabelIndex: initialValue ? 0 : 1,
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
              onToggle:  onToggle,
            ),
          ),
        ],
      ),
    );
  }
}
