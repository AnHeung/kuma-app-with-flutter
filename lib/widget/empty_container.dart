import 'package:flutter/material.dart';

class EmptyContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('' , style: TextStyle(fontSize: 20.0 ,color: Colors.grey ,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
