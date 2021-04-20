import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/character/character_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/enums/navigation_push_type.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';
import 'package:kuma_flutter_app/widget/image_scroll_container.dart';
import 'package:kuma_flutter_app/widget/image_text_scroll_item.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/title_container.dart';

import '../app_constants.dart';
import '../model/item/animation_character_item.dart';
import 'custom_text.dart';
import 'image_item.dart';

class BottomCharacterItemContainer extends StatelessWidget {
  final String characterId;
  final double itemHeight = 100;
  final double scrollItemHeight = 150;

  BottomCharacterItemContainer({this.characterId});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.75;

    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        AnimationCharacterItem characterItem = state.characterItem;

        if (state.status == CharacterStatus.loading) {
          return LoadingIndicator(
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
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: itemHeight,
                            width: itemHeight,
                            child: GestureDetector(
                                onTap: () => imageAlert(
                                    context,
                                    characterItem.name,
                                    [characterItem.imageUrl],
                                    0),
                                child: ImageItem(imgRes: characterItem.imageUrl,))),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            height: itemHeight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex:1,
                                  child: Container(
                                    child: CustomText(
                                      fontFamily: doHyunFont,
                                      fontSize: 20.0,
                                      text: characterItem.name,
                                      fontColor: kPurple,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex:1,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: CustomText(
                                      fontFamily: doHyunFont,
                                      fontSize: 15.0,
                                      text: characterItem.nameKanji,
                                      fontColor: kBlack,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: characterItem.nicknames.isNotEmpty,
                                  child: Expanded(
                                    flex:2,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: CustomText(
                                        fontFamily: doHyunFont,
                                        fontSize: 15.0,
                                        text: "닉네임 : ${characterItem.nicknames}",
                                        fontColor: kBlack,
                                        fontWeight: FontWeight.w700,
                                        maxLines: 2,
                                        isEllipsis: true,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const TitleContainer(title: "소개"),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.center,
                    child: CustomText(
                      text: characterItem.about,
                    ),
                  ),
                  const TitleContainer(title: "이미지"),
                  ImageScrollItemContainer(
                    height: 100.0,
                    title: "관련 이미지",
                    images: characterItem.pictureItems
                        .map((imageItem) => imageItem.image)
                        .toList(),
                  ),
                  const TitleContainer(title: "관련 애니"),
                  Container(
                    height: scrollItemHeight,
                    child: ListView(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        children: characterItem.relateAnimation
                            .map((item) => ImageTextScrollItemContainer(
                                  title: item.title,
                                  id: item.id,
                                  imageDiveRate: 4,
                                  image: item.image,
                                  context: context,
                                  pushType: NavigationPushType.PUSH,
                                  imageShapeType: ImageShapeType.CIRCLE,
                                ))
                            .toList()),
                  ),
                  const TitleContainer(title: "성우"),
                  _buildVoiceActorContainer(context: context , items: characterItem.voiceActors),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  _buildVoiceActorContainer({List<VoiceActorItem> items , BuildContext context}){
    return Container(
      height: scrollItemHeight,
      child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          children: items
              .map((item) => ImageTextScrollItemContainer(
            title: item.name,
            id: item.id,
            imageDiveRate: 4,
            image: item.image,
            context: context,
            pushType: NavigationPushType.PUSH,
            imageShapeType: ImageShapeType.CIRCLE,
          ))
              .toList()),
    );
  }
}
