import 'package:flutter/material.dart';

class EmptyContainer extends StatelessWidget {

  final String title;
  final double size;

  const EmptyContainer({this.title, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size,
      child: Center(
        child: Text(title , style: const TextStyle(fontSize: 20.0 ,color: Colors.grey ,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
