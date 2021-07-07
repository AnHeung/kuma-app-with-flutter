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
            const Text(kMoreNoLoginTitle),
            Container(
              height: 30,
              margin: const EdgeInsets.only(top: 10),
              color: kBlue,
              child: TextButton(
                  onPressed: () => {Navigator.pushNamed(context, Routes.LOGIN)},
                  child: CustomText(
                    fontColor: kWhite,
                    fontFamily: doHyunFont,
                    text: kLoginDialogTitle,
                    fontSize: kMoreLoginFontSize,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
