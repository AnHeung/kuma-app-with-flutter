import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/screen/onboarding/widgets/icon_container.dart';

class SecondLightCardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const IconContainer(
          icon: Icons.brush,
          padding: kPaddingS,
        ),
        const IconContainer(
          icon: Icons.camera_alt,
          padding: kPaddingM,
        ),
        const IconContainer(
          icon: Icons.straighten,
          padding: kPaddingS,
        ),
      ],
    );
  }
}
