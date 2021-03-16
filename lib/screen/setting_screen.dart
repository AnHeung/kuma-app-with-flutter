import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              child: Row(
                children: [
                  CustomText(text: "홈화면에 보여줄 아이템 갯수"  , fontSize: 20, fontColor: Colors.black,),
                  Spacer(),
                  CustomText(text: "5" , fontSize: 20,fontColor: Colors.black,),
                ],
              ),
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  CustomText(text: "홈화면 자동 스크롤"  , fontSize: 20, fontColor: Colors.black,),
                  Spacer(),
                  ToggleSwitch(
                    minWidth: 70.0,
                    cornerRadius: 20.0,
                    activeBgColor: Colors.cyan,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    labels: ['켜기', '끄기'],
                    icons: [FontAwesomeIcons.check, FontAwesomeIcons.times],
                    onToggle: (index) {
                      print('switched to: $index');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
