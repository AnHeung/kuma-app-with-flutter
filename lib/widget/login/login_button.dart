part of 'login_widget.dart';

class LoginButton extends StatelessWidget {

  final Color bgColor;
  final VoidCallback onPress;
  final String imgRes;
  final String buttonText;

  const LoginButton({this.bgColor, this.onPress, this.imgRes, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      height: 50,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: TextButton(
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 30,
              child: ImageItem(
                type: ImageShapeType.Flat,
                imgRes: imgRes,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                  width: 100,
                  child: CustomText(
                    fontFamily: doHyunFont,
                    text: buttonText,
                    fontSize: kLoginFontSize,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
