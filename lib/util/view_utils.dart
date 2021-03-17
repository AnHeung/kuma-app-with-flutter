import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/enums/image_type.dart';
import 'package:kuma_flutter_app/enums/move_state.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';

imageAlert(
    BuildContext context, String title, List<String> imgList, int imgIdx) {
  PageController controller = PageController(initialPage: imgIdx);

  showGeneralDialog(
    context: context,
    barrierColor: Colors.black12.withOpacity(0.6),
    // background color
    barrierDismissible: false,
    // should dialog be dismissed when tapped outside
    barrierLabel: "Dialog",
    // label for barrier
    transitionDuration: Duration(milliseconds: 400),
    // how long it takes to popup dialog after button click
    pageBuilder: (_, __, ___) {
      double btnHeight = MediaQuery.of(context).size.height * 0.1;
      // your widget implementation
      return Stack(
        children: [
          PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
            scrollDirection: Axis.horizontal,
            children: imgList
                .map(
                  (img) => Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: SizedBox.expand(
                            child: ImageItem(
                          type: ImageShapeType.FLAT,
                          imgRes: img,
                        )),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.transparent,
              ),
              onPressed: () => Navigator.pop(context),
              child: Container(
                height: btnHeight,
                child: CustomText(
                  fontWeight: FontWeight.w700,
                  fontColor: Colors.black54,
                  text: "나가기",
                  fontSize: 30,
                ),
              ),
            ),
          ),
          Visibility(
            visible: imgList.length > 1,
            child: GestureDetector(
              onTap: () => _controlPage(
                  listSize: imgList.length,
                  controller: controller,
                  state: MoveState.RIGHT),
              child: Container(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.chevron_right,
                    size: 100,
                    color: Colors.white70,
                  )),
            ),
          ),
          Visibility(
            visible: imgList.length > 1,
            child: GestureDetector(
              onTap: () => _controlPage(
                  listSize: imgList.length,
                  controller: controller,
                  state: MoveState.LEFT),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.chevron_left,
                    size: 100,
                    color: Colors.white70,
                  )),
            ),
          )
        ],
      );
    },
  );
}

_controlPage({int listSize, PageController controller, MoveState state}) {
  int currentPage = controller.page.ceil();
  Duration duration = Duration(milliseconds: 300);
  var curves = Curves.easeIn;

  switch (state) {
    case MoveState.LEFT:
      if (listSize > 1 && currentPage == 0)
        controller.animateToPage(listSize - 1,
            duration: duration, curve: curves);
      else
        controller.previousPage(duration: duration, curve: Curves.easeIn);
      break;
    case MoveState.RIGHT:
      if (listSize > 1 && currentPage == listSize - 1)
        controller.animateToPage(0, duration: duration, curve: curves);
      else
        controller.nextPage(duration: duration, curve: curves);
      break;
  }
}

// Future<Color> colorForBackground(Image image) async{
//
//   final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImage(image);
//   Color backgroundColor =  paletteGenerator.dominantColor.color;
//   if (ThemeData.estimateBrightnessForColor(backgroundColor) == Brightness.dark)return Colors.white;
//   return Colors.black;
// }

showToast({String msg}) {
  if (msg.isNotEmpty)
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
}

showBaseDialog(
    {String title,
    String content,
    BuildContext context,
    VoidCallback confirmFunction,
    VoidCallback cancelFunction}) {
  showDialog(
    context: context,
    barrierColor: Colors.black12.withOpacity(0.6), // background color
    barrierDismissible: false, // should dialog be dismissed when tapped outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title ?? '알림'),
        content: Text(content ?? '내용'),
        actions: <Widget>[
          TextButton(
            child: Text('확인'),
            onPressed: confirmFunction,
          ),
          TextButton(
            child: Text('취소'),
            onPressed: cancelFunction != null
                ? cancelFunction
                : () => Navigator.pop(context),
          ),
        ],
      );
    },
  );
}

showOneBtnDialog(
    {String title,
    String content,
    String confirmTxt,
    BuildContext context,
    VoidCallback confirmFunction}) {
  showDialog(
    context: context,
    barrierColor: Colors.black12.withOpacity(0.6), // background color
    barrierDismissible: false, // should dialog be dismissed when tapped outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title ?? '알림'),
        content: Text(content ?? '내용'),
        actions: <Widget>[
          TextButton(
            child: Text(confirmTxt ?? '확인'),
            onPressed: confirmFunction != null
                ? confirmFunction
                : () => Navigator.pop(context),
          ),
        ],
      );
    },
  );
}

showCheckListDialog(
    {String title,
      String content,
      String confirmTxt,
      BuildContext context,
      VoidCallback confirmFunction}) {
  showDialog(
    context: context,
    barrierColor: Colors.black12.withOpacity(0.6), // background color
    barrierDismissible: false, // should dialog be dismissed when tapped outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title ?? '알림'),
        content: Text(content ?? '내용'),
        actions: <Widget>[
          TextButton(
            child: Text(confirmTxt ?? '확인'),
            onPressed: confirmFunction != null
                ? confirmFunction
                : () => Navigator.pop(context),
          ),
        ],
      );
    },
  );
}

checkImageType(String res) {
  if (res.isEmpty) {
    return ImageType.NO_IMAGE;
  }else if(res.contains("assets/")) {
    return ImageType.ASSETS;
  }else if (res.startsWith("/data")) {
    return ImageType.FILE;
  } else {
    return ImageType.NETWORK;
  }
}
