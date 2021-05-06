import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/person/person_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_deatil_page_item.dart';
import 'package:kuma_flutter_app/model/item/animation_person_item.dart';
import 'package:kuma_flutter_app/model/item/base_scroll_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/widget/image_text_row_container.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/title_container.dart';
import 'package:kuma_flutter_app/widget/title_image_more_container.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_constants.dart';
import 'custom_text.dart';

class BottomVoiceItemContainer extends StatelessWidget {
  final String personId;
  final double itemHeight = 100;
  final double scrollItemHeight = 150;

  const BottomVoiceItemContainer({this.personId});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.5;

    return BlocBuilder<PersonBloc, PersonState>(
      builder: (context, state) {
        AnimationPersonItem personItem = state.personItem;
        if (state.status == PersonStateStatus.loading) {
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
                  const TitleContainer(title: "사이트"),
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
                  const TitleContainer(title: "소개"),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.center,
                    child: CustomText(
                      text: personItem.about,
                    ),
                  ),
                  TitleImageMoreContainer(
                    categoryTitle: kAnimationDetailRelateTitle,
                    height: scrollItemHeight,
                    imageDiveRate: 4,
                    imageShapeType: ImageShapeType.CIRCLE,
                    baseItemList: personItem.voiceActingRoles
                        .map((data) => BaseScrollItem(
                              id: data.animationItem.malId,
                              title: data.animationItem.name,
                              image: data.animationItem.imageUrl,
                              onTap: () => Navigator.pushReplacementNamed(
                                  context, Routes.IMAGE_DETAIL,
                                  arguments: AnimationDetailPageItem(
                                      id: data.animationItem.malId,
                                      title: data.animationItem.name)),
                            ))
                        .toList(),
                  ),
                  TitleImageMoreContainer(
                    categoryTitle: "맡은 캐릭터",
                    height: scrollItemHeight,
                      imageDiveRate: 4,
                      imageShapeType: ImageShapeType.CIRCLE,
                    baseItemList: personItem.voiceActingRoles
                        .map((data) => BaseScrollItem(
                            id: data.characterItem.characterId,
                            title: data.characterItem.name,
                            image: data.characterItem.imageUrl,
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
