import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/character_detail/character_detail_bloc.dart';
import 'package:kuma_flutter_app/enums/base_bloc_state_status.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/base_scroll_item.dart';
import 'package:kuma_flutter_app/model/item/bottom_more_item.dart';
import 'package:kuma_flutter_app/util/common.dart';
import 'package:kuma_flutter_app/widget/bottom/bottom_more_item_container.dart';
import 'package:kuma_flutter_app/widget/common/image_scroll_container.dart';
import 'package:kuma_flutter_app/widget/common/image_text_row_container.dart';
import 'package:kuma_flutter_app/widget/common/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/common/title_container.dart';
import 'package:kuma_flutter_app/widget/common/title_image_more_container.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_constants.dart';
import '../../model/item/animation_character_detail_item.dart';
import '../common/custom_text.dart';

class BottomCharacterItemContainer extends StatelessWidget {
  final double itemHeight = 100;
  final double scrollItemHeight = 150;

  const BottomCharacterItemContainer();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.75;

    return BlocBuilder<CharacterDetailBloc, CharacterState>(
      builder: (context, state) {
        AnimationCharacterDetailItem characterItem = state.characterItem;

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
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Column(
                children: [
                  ImageTextRowContainer(
                    nickName: characterItem.nicknames,
                    imageUrl: characterItem.imageUrl,
                    title: characterItem.name,
                    midName: characterItem.nameKanji,
                    itemHeight: itemHeight,
                  ),
                  const TitleContainer(title: kBottomContainerSiteTitle),
                  Visibility(
                    visible: characterItem.url.isNotEmpty,
                    child: GestureDetector(
                      onTap: () async => {
                        await canLaunch(characterItem.url)
                            ? await launch(characterItem.url)
                            : throw 'Could not launch ${characterItem.url}'
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          fontColor: kBlue,
                          text: characterItem.url,
                        ),
                      ),
                    ),
                  ),
                  const TitleContainer(title: kBottomContainerIntroduceTitle),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: characterItem.about,
                    ),
                  ),
                  const TitleContainer(title:kBottomContainerImageTitle),
                  ImageScrollItemContainer(
                    height: 100.0,
                    title: kAnimationDetailImageTitle,
                    images: characterItem.pictureItems
                        .map((imageItem) => imageItem.image)
                        .toList(),
                  ),
                  TitleImageMoreContainer(
                    onClick: ()=>
                      moveToBottomMoreItemContainer(
                          title: kAnimationDetailRelateTitle,
                          type: BottomMoreItemType.Animation,
                          context: context, items: characterItem.relateAnimation
                          .map((relateAnimationItem) => BottomMoreItem(
                          id: relateAnimationItem.id,
                          title: relateAnimationItem.title,
                          imgUrl: relateAnimationItem.image))
                          .toList()),
                    categoryTitle: kAnimationDetailRelateTitle,
                    height: scrollItemHeight,
                    imageDiveRate: 4,
                    imageShapeType: ImageShapeType.Circle,
                    baseItemList: characterItem.relateAnimation
                        .map((data) => BaseScrollItem(
                              id: data.id,
                              title: data.title,
                              image: data.image,
                              onTap: () => moveToAnimationDetailScreen(context: context, id: data.id, title: data.title),
                            ))
                        .toList(),
                  ),
                  TitleImageMoreContainer(
                    onClick: ()=>{
                      moveToBottomMoreItemContainer(
                        title: kBottomContainerVoiceTitle,
                          type: BottomMoreItemType.Voice,
                          context: context, items: characterItem.voiceActors
                          .map((voiceItem) => BottomMoreItem(
                          id: voiceItem.id,
                          title: voiceItem.name,
                          imgUrl: voiceItem.image))
                          .toList())
                    },
                    categoryTitle: kBottomContainerVoiceTitle,
                    height: scrollItemHeight,
                    imageDiveRate: 4,
                    imageShapeType: ImageShapeType.Circle,
                    baseItemList: characterItem.voiceActors
                        .map((item) => BaseScrollItem(
                              id: item.id,
                              title: item.name,
                              image: item.image,
                              onTap: () => showVoiceBottomSheet(context: context, id:item.id),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
