import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';


class FirstDarkCardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Padding(
          padding: const EdgeInsets.only(top: kPaddingL),
          child: const Icon(
            Icons.brush,
            color: kWhite,
            size: 32.0,
          ),
        ),
        const Padding(
          padding: const EdgeInsets.only(bottom: kPaddingL),
          child: Icon(
            Icons.camera_alt,
            color: kWhite,
            size: 32.0,
          ),
        ),
        const  Padding(
          padding: const EdgeInsets.only(top: kPaddingL),
          child: Icon(
            Icons.straighten,
            color: kWhite,
            size: 32.0,
          ),
        ),
      ],
    );
  }
}
