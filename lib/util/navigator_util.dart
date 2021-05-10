import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/model/item/animation_deatil_page_item.dart';
import 'package:kuma_flutter_app/model/item/bottom_more_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/widget/bottom_more_item_container.dart';

navigateWithUpAnimation({BuildContext context , Widget navigateScreen}){
  Navigator.push(context, PageRouteBuilder(pageBuilder: (context,animation, secondaryAnimation)=> navigateScreen ,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },));
}

moveToBottomMoreItemContainer({String title , @required BuildContext context,List<BottomMoreItem> items =const <BottomMoreItem>[] , @required BottomMoreItemType type}){
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (_) => BottomMoreItemContainer(
        title: title,
        type: type,
        moreItems: items,
      ));
}

moveToAnimationDetailScreen({@required BuildContext context, String id,  String title}){
  Navigator.popUntil(context, ModalRoute.withName(Routes.IMAGE_DETAIL));
  Navigator.popAndPushNamed(
      context, Routes.IMAGE_DETAIL,
      arguments: AnimationDetailPageItem(
          id: id,
          title: title));
}

moveToHomeScreen({@required BuildContext context}){
  Navigator.popUntil(context, ModalRoute.withName(Routes.HOME));
}

