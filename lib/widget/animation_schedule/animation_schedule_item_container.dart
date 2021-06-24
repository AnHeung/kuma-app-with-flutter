part of 'animation_schedule_widget.dart';

class AnimationScheduleItemContainer extends StatelessWidget {

  final AnimationScheduleItem item;

  const AnimationScheduleItemContainer({this.item});

  @override
  Widget build(BuildContext context) {

    double score = item.score != "null" ?  double.parse(item.score)/2 : 0;
    return GestureDetector(
      onTap: ()=>Navigator.pushNamed(context,Routes.IMAGE_DETAIL, arguments: AnimationDetailPageItem(id: item.id.toString(), title: item.title)),
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        child: Row(
          children: [
            Container(
              child: Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                child: ImageItem(
                  imgRes: item.image,
                  type: ImageShapeType.Flat,
                ),
              ),
            ),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: CustomText(
                            text: item.title,
                            isEllipsis: true,
                            fontSize: 12.0,
                            fontFamily: doHyunFont,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          child: RatingBar(
                            rating: score,
                            icon:const Icon(Icons.star,size:20,color: Colors.white,),
                            starCount: 5,
                            spacing: 5.0,
                            size: 10,
                            isIndicator: false,
                            allowHalfRating: false,
                            onRatingCallback: (double value,ValueNotifier<bool> isIndicator){
                              print('Number of stars-->  $value');
                              //change the isIndicator from false  to true ,the       RatingBar cannot support touch event;
                              isIndicator.value=true;
                            },
                            color: Colors.amber,
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
