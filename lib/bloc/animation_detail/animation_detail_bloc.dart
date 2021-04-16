import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_detail_item.dart';
import 'package:kuma_flutter_app/model/item/animation_detail_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';
part 'animation_detail_event.dart';
part 'animation_detail_state.dart';

class AnimationDetailBloc extends Bloc<AnimationDetailEvent, AnimationDetailState> {

  ApiRepository repository;

  AnimationDetailBloc({this.repository})
      : super(AnimationDetailLoadInProgress());

  @override
  Stream<AnimationDetailState> mapEventToState(
      AnimationDetailEvent event) async* {
    if (event is AnimationDetailLoad) {
      yield* _mapToAnimationDetailLoad(event);
    }
  }


  Stream<AnimationDetailState> _mapToAnimationDetailLoad(
      AnimationDetailLoad event) async* {
    try {
      yield AnimationDetailLoadInProgress();
      String id = event.id;
      SearchMalDetailApiItem malDetailApiItem = await repository
          .getDetailApiItem(id);
      if (malDetailApiItem.err) {
        yield AnimationDetailLoadFailure(errMsg: malDetailApiItem.msg);
      } else {
        SearchMalDetailApiItemResult result = malDetailApiItem.result;
        List<RelatedAnimeItem> relateItemList = result.relatedAnime.map((
            item) =>
            RelatedAnimeItem(id: item.id, image: item.image, title: item.title))
            .toList();
        List<RecommendationAnimeItem> recommendList = result.recommendAnime
            .map((item) =>
            RecommendationAnimeItem(
                id: item.id, image: item.image, title: item.title)).toList();
        List<StudioItem> studioList = result.studios.map((item) =>
            StudioItem(id: item.id, name: item.name)).toList();
        List<AnimationDetailGenreItem> genreList = result.genres.map((item) => AnimationDetailGenreItem(id: item.id, name: item.name)).toList();
        List<VideoItem> videoList = result.videos!= null ? result.videos.map((item) => VideoItem(title:item.title, videoUrl: item.video_url , imageUrl: item.image_url)).toList() : [];
        List<CharacterItem> characterList = result.characters!= null ? result.characters.map((item) => CharacterItem(name: item.name, characterId: item.character_id,  imageUrl: item.image_url,  role: item.role , url: item.url)).toList() : [];

        yield AnimationDetailLoadSuccess(detailItem: AnimationDetailItem(
            id: result.id,
            image: result.image,
            title: result.title,
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
            studioItems: studioList , videoItems:videoList , characterItems: characterList));
      }
    } catch (e) {
      yield AnimationDetailLoadFailure(
          errMsg: "_mapToAnimationDetailLoad 에러 $e");
    }
  }
}
