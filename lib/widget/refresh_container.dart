import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';

class RefreshContainer extends StatelessWidget {

 final GestureTapCallback callback;

 const RefreshContainer({this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: GestureDetector(
          onTap: callback,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: CustomText(text: "다시 시도해주세요", fontSize: 10.0, fontColor: kBlue,),
              ),
              Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                child: const Icon(Icons.refresh, color: kBlue, size: 30,),
      ),
            ],
          ),
        ),
    );
  }
}
