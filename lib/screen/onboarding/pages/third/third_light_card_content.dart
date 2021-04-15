import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/screen/onboarding/widgets/icon_container.dart';


class ThirdLightCardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const IconContainer(
          icon: Icons.event_seat,
          padding: kPaddingS,
        ),
        const IconContainer(
          icon: Icons.business_center,
          padding: kPaddingM,
        ),
        const IconContainer(
          icon: Icons.assessment,
          padding: kPaddingS,
        ),
      ],
    );
  }
}
