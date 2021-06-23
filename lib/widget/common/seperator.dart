import 'package:flutter/cupertino.dart';

class Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        height: 2.0,
        width: double.infinity,
        color: const Color(0xff00c6ff));
  }
}