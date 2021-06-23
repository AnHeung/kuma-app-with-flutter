import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';

class ThirdDarkCardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Icon(
              Icons.person_pin,
              color: kWhite,
              size: 32.0,
            ),
          ],
        ),
        const SizedBox(height: kSpaceM),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Icon(
              Icons.person,
              color: kWhite,
              size: 32.0,
            ),
            const Icon(
              Icons.group,
              color: kWhite,
              size: 32.0,
            ),
            const Icon(
              Icons.insert_emoticon,
              color: kWhite,
              size: 32.0,
            ),
          ],
        ),
      ],
    );
  }
}
