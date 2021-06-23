import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/person/person_bloc.dart';
import 'package:kuma_flutter_app/enums/base_bloc_state_status.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_person_item.dart';
import 'package:kuma_flutter_app/model/item/base_scroll_item.dart';
import 'package:kuma_flutter_app/model/item/bottom_more_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/util/common.dart';
import 'package:kuma_flutter_app/widget/bottom/bottom_more_item_container.dart';
import 'package:kuma_flutter_app/widget/common/custom_text.dart';
import 'package:kuma_flutter_app/widget/common/image_text_row_container.dart';
import 'package:kuma_flutter_app/widget/common/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/common/title_container.dart';
import 'package:kuma_flutter_app/widget/common/title_image_more_container.dart';
import 'package:url_launcher/url_launcher.dart';


class BottomVoiceItemContainer extends StatelessWidget {
  final double itemHeight = 100;
  final double scrollItemHeight = 150;

  const BottomVoiceItemContainer();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.5;

    return BlocBuilder<PersonBloc, PersonState>(
      builder: (context, state) {
        AnimationPersonItem personItem = state.personItem;
        if (state.status == BaseBlocStateStatus.Loading) {
          return const LoadingIndicator(
            isVisible: true,
          );
        }
        return Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            decoration: const BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            height: height,
            child: ListView(scrollDirection: Axis.vertical, children: [
              Column(
                children: [
                  ImageTextRowContainer(
                    title: personItem.name,
                    imageUrl: personItem.imageUrl,
                    itemHeight: itemHeight,
                    midName: "${personItem.familyName} ${personItem.givenName}",
                    nickName: personItem.alternateNames,
                  ),
                  const TitleContainer(title: kBottomContainerSiteTitle),
                  Visibility(
                    visible: personItem.url.isNotEmpty,
                    child: GestureDetector(
                      onTap: () async => {
                        await canLaunch(personItem.url)
                            ? await launch(personItem.url)
                            : throw 'Could not launch ${personItem.url}'
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          fontColor: kBlue,
                          text: personItem.url,
                        ),
                      ),
                    ),
                  ),
                  const TitleContainer(title: kBottomContainerIntroduceTitle),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.center,
                    child: CustomText(
                      text: personItem.about,
                    ),
                  ),
                  TitleImageMoreContainer(
                    onClick: () => moveToBottomMoreItemContainer(
                        title: kAnimationDetailRelateTitle,
                        type: BottomMoreItemType.Animation,
                        context: context,
                        items: personItem.voiceActingRoles
                            .map((relateAnimationItem) => BottomMoreItem(
                                id: relateAnimationItem.animationItem.malId,
                                title: relateAnimationItem.animationItem.name,
                                imgUrl:
                                    relateAnimationItem.animationItem.imageUrl))
                            .toList()),
                    categoryTitle: kAnimationDetailRelateTitle,
                    height: scrollItemHeight,
                    imageDiveRate: 4,
                    imageShapeType: ImageShapeType.Circle,
                    baseItemList: personItem.voiceActingRoles
                        .map((data) => BaseScrollItem(
                              id: data.animationItem.malId,
                              title: data.animationItem.name,
                              image: data.animationItem.imageUrl,
                              onTap: () => moveToAnimationDetailScreen(
                                  context: context,
                                  id: data.animationItem.malId,
                                  title: data.animationItem.name),
                            ))
                        .toList(),
                  ),
                  TitleImageMoreContainer(
                    onClick: () => moveToBottomMoreItemContainer(
                        title: kBottomContainerCharacterTitle,
                        type: BottomMoreItemType.Character,
                        context: context,
                        items: personItem.voiceActingRoles
                            .map((characterItem) => BottomMoreItem(
                                id: characterItem.characterItem.characterId,
                                title: characterItem.characterItem.name,
                                imgUrl: characterItem.characterItem.imageUrl))
                            .toList()),
                    categoryTitle: kBottomContainerCharacterTitle,
                    height: scrollItemHeight,
                    imageDiveRate: 4,
                    imageShapeType: ImageShapeType.Circle,
                    baseItemList: personItem.voiceActingRoles
                        .map((data) => BaseScrollItem(
                              id: data.characterItem.characterId,
                              title: data.characterItem.name,
                              image: data.characterItem.imageUrl,
                              onTap: () {
                                Navigator.popUntil(context, ModalRoute.withName(Routes.IMAGE_DETAIL));
                                showCharacterBottomSheet(
                                    id: data.characterItem.characterId,
                                    context: context);
                              }
                            ))
                        .toList(),
                  ),
                ],
              ),
            ]));
      },
    );
  }
}
