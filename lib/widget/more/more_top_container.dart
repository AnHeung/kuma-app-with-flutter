part of 'more_widget.dart';

class MoreTopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top + 20;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: statusBarHeight, left: 20, right: 20),
        child: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: '더보기',
                  fontSize: kMoreTitleFontSize,
                  fontWeight: FontWeight.w700,
                  fontColor: Colors.black,
                )),
            MoreCategoryContainer()
          ],
        ),
      ),
    );
  }
}
