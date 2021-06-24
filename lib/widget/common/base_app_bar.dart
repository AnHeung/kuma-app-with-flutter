import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BaseAppbar extends StatefulWidget implements PreferredSizeWidget{

  const BaseAppbar({Key key}) : preferredSize = const Size.fromHeight(kToolbarHeight) , super(key: key);

  @override
  final Size preferredSize;

}
