part of 'more_widget.dart';

class NeedLoginContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('로그인이 되어 있지 않습니다.'),
            Container(
              height: 30,
              margin: const EdgeInsets.only(top: 10),
              color: kBlue,
              child: TextButton(
                  onPressed: () => {Navigator.pushNamed(context, Routes.LOGIN)},
                  child: CustomText(
                    fontColor: kWhite,
                    fontFamily: doHyunFont,
                    text: "로그인/회원가입",
                    fontSize: kMoreLoginFontSize,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
