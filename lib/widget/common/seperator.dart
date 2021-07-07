import 'package:flutter/cupertino.dart';
import 'package:kuma_flutter_app/app_constants.dart';

class Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: kDefaultSeparatorMidGap),
        height: kDefaultSeparatorTopGap,
        width: double.infinity,
        color: const Color(0xff00c6ff));
  }
}