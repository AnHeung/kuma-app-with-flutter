import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/character/character_bloc.dart';

class BottomCharacterItemContainer extends StatelessWidget {

  final String characterId;

  BottomCharacterItemContainer({this.characterId});

  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height * 0.75;

    return BlocBuilder<CharacterBloc,CharacterState>(
      builder: (context,state){
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          height: height,
        );
      },
    );
  }
}
