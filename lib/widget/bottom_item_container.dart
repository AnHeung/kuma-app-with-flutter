import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/model/item/animation_detail_item.dart';

class BottomCharacterItemContainer extends StatelessWidget {

  final List<CharacterItem> items;

  BottomCharacterItemContainer({this.items});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 2;

    return Container(
      height: height,
    );
  }
}
