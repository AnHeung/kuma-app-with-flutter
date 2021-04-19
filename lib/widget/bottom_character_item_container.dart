import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/character/character_bloc.dart';

import '../app_constants.dart';
import '../model/item/animation_character_item.dart';
import 'custom_text.dart';
import 'custom_text.dart';
import 'image_item.dart';

class BottomCharacterItemContainer extends StatelessWidget {

  final String characterId;

  BottomCharacterItemContainer({this.characterId});

  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height * 0.75;

    return BlocBuilder<CharacterBloc,CharacterState>(
      builder: (context,state){

        AnimationCharacterItem characterItem = state.characterItem;
        print(characterItem);

        return Container(
          padding: const EdgeInsets.only(left: 20 , right: 20, top: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          height: height,
          child: Column(
            children: [
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 100,  width:100 ,child: ImageItem(imgRes: characterItem.imageUrl,)),
                     Container(
                       height: 100,
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Container(padding:const EdgeInsets.only(left: 10), alignment: Alignment.center, child: CustomText(fontFamily:doHyunFont , fontSize:25.0,
                               text:characterItem.name, fontColor: kPurple, fontWeight: FontWeight.w700,),),
                           Container(padding:const EdgeInsets.only(left: 10) , alignment: Alignment.center, child: CustomText(fontFamily:doHyunFont , fontSize:18.0,
                               text:characterItem.nameKanji, fontColor: kBlack, fontWeight: FontWeight.w700,),),
                           Container(padding:const EdgeInsets.only(left: 10) , alignment: Alignment.center, child: CustomText(fontFamily:doHyunFont , fontSize:18.0,
                               text:"닉네임 : ${characterItem.nicknames}", fontColor: kBlack, fontWeight: FontWeight.w700,),),
                         ],
                       ),
                     ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: CustomText(text: "소개",),
              ),
              Container(
                alignment: Alignment.center,
                child: CustomText(text: characterItem.about,),
              )
            ],
          ),
        );
      },
    );
  }
}
