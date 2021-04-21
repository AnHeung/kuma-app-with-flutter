import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/character/character_bloc.dart';
import 'package:kuma_flutter_app/bloc/person/person_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/enums/navigation_push_type.dart';
import 'package:kuma_flutter_app/model/item/animation_deatil_page_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';
import 'package:kuma_flutter_app/widget/bottom_voice_item_container.dart';
import 'package:kuma_flutter_app/widget/image_scroll_container.dart';
import 'package:kuma_flutter_app/widget/image_text_row_container.dart';
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
                  ImageTextRowContainer(nickName:characterItem.nicknames , imageUrl: characterItem.imageUrl , title: characterItem.name , midName: characterItem.nameKanji , itemHeight: itemHeight ,),
                  const TitleContainer(title: "사이트"),
                  Visibility(
                    visible: characterItem.url.isNotEmpty,
                    child: GestureDetector(
                      onTap: ()async =>{
                      await canLaunch(characterItem.url) ? await launch(characterItem.url) : throw 'Could not launch ${characterItem.url}'
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
                                  onTap: ()=> Navigator.pushNamed(context, Routes.IMAGE_DETAIL, arguments: AnimationDetailPageItem(id: item.id, title: item.title)),
                                  title: item.title,
                                  id: item.id,
                                  imageDiveRate: 4,
                                  image: item.image,
                                  context: context,
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
            onTap: ()=> showModalBottomSheet(
                backgroundColor: Colors.transparent,
                isScrollControlled:true,
                context: context,
                builder: (_) {
                  return BlocProvider(create: (_)=>PersonBloc(repository: context.read<ApiRepository>())..add(PersonLoad(personId:item.id)), child: BottomVoiceItemContainer(personId: item.id,),);
                }),
            title: item.name,
            id: item.id,
            imageDiveRate: 4,
            image: item.image,
            context: context,
            imageShapeType: ImageShapeType.CIRCLE,
          ))
              .toList()),
    );
  }
}
