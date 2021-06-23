import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HeaderLogo extends StatelessWidget {
  final Color color;
  final double size;

  const HeaderLogo({
    @required this.color,
    @required this.size,
  })  : assert(color != null),
        assert(size != null);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 4,
      child: Icon(
        Icons.text_fields,
        color: color,
        size: size,
      ),
    );
  }
}
