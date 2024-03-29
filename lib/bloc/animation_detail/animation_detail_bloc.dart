import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/enums/base_bloc_state_status.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_detail_item.dart';
import 'package:kuma_flutter_app/model/item/animation_detail_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';
import 'package:kuma_flutter_app/util/common.dart';

part 'animation_detail_event.dart';
part 'animation_detail_state.dart';

class AnimationDetailBloc extends Bloc<AnimationDetailEvent, AnimationDetailState> {

  ApiRepository repository;

  AnimationDetailBloc({this.repository})
      : super(const AnimationDetailState());

  @override
  Stream<AnimationDetailState> mapEventToState(
      AnimationDetailEvent event) async* {
    if (event is AnimationDetailLoad) {
      yield* _mapToAnimationDetailLoad(event);
    }else if(event is AnimationDetailVideoLoad){
      yield* _mapToAnimationDetailVideoLoad(event);
    }
  }

  Stream<AnimationDetailState> _mapToAnimationDetailVideoLoad(AnimationDetailVideoLoad event) async*{
    yield state.copyWith(status: BaseBlocStateStatus.Success , detailItem: event.detailItem);
  }

  Stream<AnimationDetailState> _mapToAnimationDetailLoad(
      AnimationDetailLoad event) async* {
    try {
      yield const AnimationDetailState(status: BaseBlocStateStatus.Loading);
      String id = event.id;
      SearchMalDetailApiItem malDetailApiItem = await repository.getDetailApiItem(id);
      if (malDetailApiItem.err) {
        yield state.copyWith(status:BaseBlocStateStatus.Failure, msg: malDetailApiItem.msg);
      } else {
        SearchMalDetailApiItemResult result = malDetailApiItem.result;
        List<RelatedAnimeItem> relateItemList = result.relatedAnime.map((item) => RelatedAnimeItem(id: item.id, image: item.image, title: item.title)).toList();
        List<RecommendationAnimeItem> recommendList = result.recommendAnime.map((item) => RecommendationAnimeItem(id: item.id, image: item.image, title: item.title)).toList();
        List<StudioItem> studioList = result.studios.map((item) => StudioItem(id: item.id, name: item.name)).toList();
        List<AnimationDetailGenreItem> genreList = result.genres.map((item) => AnimationDetailGenreItem(id: item.id, name: item.name)).toList();
        List<VideoItem> videoList = result.videos!= null ? result.videos.map((item) => VideoItem(title:item.title, videoUrl: item.video_url , imageUrl: item.image_url)).toList() : [];
        List<CharacterItem> characterList = result.characters!= null ? result.characters.map((item) => CharacterItem(name: item.name, characterId: item.character_id,  imageUrl: item.image_url,  role: item.role , url: item.url)).toList() : [];
        String selectVideoUrl = !result.videos.isNullOrEmpty ? result.videos[0].video_url : "";

        yield AnimationDetailState(status:BaseBlocStateStatus.Success ,detailItem: AnimationDetailItem(
            id: result.id,
            image: result.image,
            title: result.title,
            titleEn: result.titleEn,
            startDate: result.startDate,
            endDate: result.endDate,
            star: result.star,
            popularity: result.popularity,
            rank: result.rank,
            percent: (double.parse(result.star) / 10.ceil()).toString(),
            percentText: "${(double.parse(result.star) * 10).toStringAsFixed(
                1)}%",
            synopsis: result.synopsis,
            status: result.status,
            genres: genreList,
            numEpisodes: result.numEpisodes,
            startSeason: result.startSeason,
            pictures: result.pictures,
            relatedAnime: relateItemList,
            recommendationAnimes: recommendList,
            studioItems: studioList , videoItems:videoList , characterItems: characterList , selectVideoUrl:selectVideoUrl));
      }
    } catch (e) {
      print('_mapToAnimationDetailLoad Error :$e');
      yield state.copyWith(status:BaseBlocStateStatus.Failure, msg:  "상세목록 불러오기 오류");
    }
  }
}
