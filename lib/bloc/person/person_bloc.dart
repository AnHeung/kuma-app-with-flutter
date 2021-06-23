import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/enums/base_bloc_state_status.dart';
import 'package:kuma_flutter_app/model/api/search_mal_person_item.dart';
import 'package:kuma_flutter_app/model/item/animation_person_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final ApiRepository repository;

  PersonBloc({this.repository}) : super(const PersonState());

  @override
  Stream<PersonState> mapEventToState(
    PersonEvent event,
  ) async* {
    if (event is PersonLoad) {
      yield* _mapToPersonLoad(event);
    }
  }

  Stream<PersonState> _mapToPersonLoad(PersonLoad event) async* {
    try {
      yield state.copyWith(status: BaseBlocStateStatus.Loading);
      String personId = event.personId;
      SearchMalPersonItem item = await repository.getPersonInfo(personId);
      if (item.err) {
        yield state.copyWith(status: BaseBlocStateStatus.Failure, msg: item.msg);
      }else{
        final result = item.result;
        final List<RoleItem> roleItems =  result.voiceActingRoles != null ? result.voiceActingRoles.map((item) => RoleItem(
          role: item.role , animationItem: PersonAnimationItem(name: item.anime.name,  imageUrl: item.anime.imageUrl,  url: item.anime.url , malId: item.anime.malId),
            characterItem: PersonCharacterItem(url: item.character.url ,imageUrl: item.character.imageUrl , name: item.character.name , characterId: item.character.characterId)
        )).toList() : [];
        yield PersonState(status: BaseBlocStateStatus.Success , personItem: AnimationPersonItem(givenName: result.givenName , url: result.url , imageUrl: result.imageUrl, name: result.name, about: result.about , alternateNames: result.alternateNames
          ,birthday: result.birthday ,familyName: result.familyName, favoritesRank: result.favoritesRank, personId: result.personId, voiceActingRoles:roleItems ));
      }
    } catch (e) {
      print('_mapToPersonLoad error :$e');
      yield state.copyWith(status: BaseBlocStateStatus.Failure , msg: "_mapToPersonLoad :${e}");
    }
  }
}
