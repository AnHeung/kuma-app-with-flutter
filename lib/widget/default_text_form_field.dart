
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DefaultTextFormField extends StatelessWidget {

  final String title;
  final double textSize;
  final TextEditingController controller;
  final bool autoFocus;
  final int maxLines;
  final bool isObscureText;
  final FormFieldValidator<String> validator;

  DefaultTextFormField({this.title, this.textSize, this.controller, this.maxLines, this.autoFocus,
    this.isObscureText,  this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(fontSize: textSize ?? 12),
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.left,
      autofocus: autoFocus ?? false,
      decoration: InputDecoration(
        //텍스트필드 validation 오류 낫을때 height 크기변경 방지
          counterText: ' ',
          border: OutlineInputBorder(),
          labelText: title,
          //일반적으로 InputDecorator에 여러 줄의 TextField가 포함 된 경우 true로 설정되어 레이블을 TextField의 중앙에 정렬하는 기본 동작을 재정의합니다.
          alignLabelWithHint: true),
      validator: validator,
      maxLines: maxLines ?? 1,
    );
  }
}