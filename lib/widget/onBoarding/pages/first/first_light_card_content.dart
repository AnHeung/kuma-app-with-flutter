import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/widget/onBoarding/widgets/icon_container.dart';

class FirstLightCardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const IconContainer(
          icon: Icons.person,
          padding: kPaddingS,
        ),
        const IconContainer(
          icon: Icons.group,
          padding: kPaddingM,
        ),
        const IconContainer(
          icon: Icons.insert_emoticon,
          padding: kPaddingS,
        ),
      ],
    );
  }
}
