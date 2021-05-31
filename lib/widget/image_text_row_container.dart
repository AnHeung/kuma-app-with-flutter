
import 'package:flutter/widgets.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';

class ImageTextRowContainer extends StatelessWidget {

  final double itemHeight;
  final String title;
  final String midName;
  final String nickName;
  final String imageUrl;

  const ImageTextRowContainer({this.itemHeight, this.title, this.midName, this.nickName, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    print('name: ${title},  nickname: ${nickName}');
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: itemHeight,
              width: itemHeight,
              child: GestureDetector(
                  onTap: () => showImageDialog(
                      context,
                      title,
                      [imageUrl],
                      0),
                  child: ImageItem(imgRes: imageUrl,))),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              height: itemHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: CustomText(
                        fontFamily: doHyunFont,
                        fontSize: 20.0,
                        text: title,
                        fontColor: kPurple,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                   Container(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        fontFamily: doHyunFont,
                        fontSize: 15.0,
                        text: midName,
                        fontColor: kBlack,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  Visibility(
                    visible: nickName.isNotEmpty,
                    child:  Container(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          fontFamily: doHyunFont,
                          fontSize: 15.0,
                          text: "닉네임 : ${nickName}",
                          fontColor: kBlack,
                          fontWeight: FontWeight.w700,
                          maxLines: 1,
                          isEllipsis: true,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
