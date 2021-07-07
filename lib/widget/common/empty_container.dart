import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';

class EmptyContainer extends StatelessWidget {

  final String title;
  final double size;

  const EmptyContainer({this.title = kEmptyScreenDefaultMsg, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size,
      child: Center(
        child: Text(title , style: const TextStyle(fontSize: kDefaultEmptyContainerFontSize ,color: Colors.grey ,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
