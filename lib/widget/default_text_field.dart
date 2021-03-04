import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DefaultTextField extends StatelessWidget {
  final String title;
  final double textSize;
  final TextEditingController controller;
  final int maxLines;
  final bool isObscureText;

  DefaultTextField(
      {this.title,
      this.textSize,
      this.controller,
      this.maxLines,
      this.isObscureText});

  @override
  Widget build(BuildContext context) {


    return TextField(

      style: TextStyle(fontSize: textSize ?? 12),
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.left,
      //텍스트 암호화 유무
      obscureText: isObscureText ?? false,
      decoration: InputDecoration(
          counterText: ' ',
          border: OutlineInputBorder(),
          labelText: title ?? '',
          //일반적으로 InputDecorator에 여러 줄의 TextField가 포함 된 경우 true로 설정되어 레이블을 TextField의 중앙에 정렬하는 기본 동작을 재정의합니다.
          alignLabelWithHint: true),
      maxLines: maxLines ?? 1,
    );
  }
}
