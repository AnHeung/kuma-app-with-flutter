import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/screen/onboarding/onboarding.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Onboarding(screenHeight: MediaQuery.of(context).size.height,),
    );
  }
}
