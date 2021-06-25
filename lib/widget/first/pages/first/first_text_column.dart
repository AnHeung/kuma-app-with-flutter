import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/widget/first/widgets/text_column.dart';

class FirstTextColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const TextColumn(
      title: '페이지1',
      text:
          '페이지 페이지 페이지',
    );
  }
}
