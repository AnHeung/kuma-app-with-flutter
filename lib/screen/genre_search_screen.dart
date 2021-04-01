import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/enums/category_click_status.dart';
import 'package:kuma_flutter_app/enums/genre_title.dart';
import 'package:kuma_flutter_app/util/date_util.dart';

/**
 *
    Anime Types    Manga Types
    tv                manga
    ova                novel
    movie            oneshot
    special            doujin
    ona                manhwa
    music            manhua


    Anime Status            Manga Status
    airing                 publishing
    completed             completed
    complete (alias)         complete (alias)
    to_be_aired             to_be_published
    tba (alias)         tbp (alias)
    upcoming (alias)       upcoming (alias)


    rate
    g    G - All Ages
    pg    PG - Children
    pg13    PG-13 - Teens 13 or older
    r17    R - 17+ recommended (violence & profanity)
    r    R+ - Mild Nudity (may also contain violence & profanity)
    rx    Rx - Hentai (extreme sexual content/nudity)


    sort
    Anime & Manga Sort
    ascending
    asc (alias)
    descending
    desc (alias)
    genre
    Anime Genre    Manga Genre
    Action: 1    Action: 1
    Adventure: 2    Adventure: 2
    Cars: 3    Cars: 3
    Comedy: 4    Comedy: 4
    Dementia: 5    Dementia: 5
    Demons: 6    Demons: 6
    Mystery: 7    Mystery: 7
    Drama: 8    Drama: 8
    Ecchi: 9    Ecchi: 9
    Fantasy: 10    Fantasy: 10
    Game: 11    Game: 11
    Hentai: 12    Hentai: 12
    Historical: 13    Historical: 13
    Horror: 14    Horror: 14
    Kids: 15    Kids: 15
    Magic: 16    Magic: 16
    Martial Arts: 17    Martial Arts: 17
    Mecha: 18    Mecha: 18
    Music: 19    Music: 19
    Parody: 20    Parody: 20
    Samurai: 21    Samurai: 21
    Romance: 22    Romance: 22
    School: 23    School: 23
    Sci Fi: 24    Sci Fi: 24
    Shoujo: 25    Shoujo: 25
    Shoujo Ai: 26    Shoujo Ai: 26
    Shounen: 27    Shounen: 27
    Shounen Ai: 28    Shounen Ai: 28
    Space: 29    Space: 29
    Sports: 30    Sports: 30
    Super Power: 31    Super Power: 31
    Vampire: 32    Vampire: 32
    Yaoi: 33    Yaoi: 33
    Yuri: 34    Yuri: 34
    Harem: 35    Harem: 35
    Slice Of Life: 36    Slice Of Life: 36
    Supernatural: 37    Supernatural: 37
    Military: 38    Military: 38
    Police: 39    Police: 39
    Psychological: 40    Psychological: 40
    Thriller: 41    Seinen: 41
    Seinen: 42    Josei: 42
    Josei: 43    Doujinshi: 43
    Gender Bender: 44
    Thriller: 45


    start_date , end_date format yyyy-mm-dd


    genre_exclue =>  0 exclude/ 1 include
 */

class GenreSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
    final AppBar appBar = AppBar(
      actions: [Container()],
      title: Text('장르검색'),
    );
    final height = appBar.preferredSize.height;

    return Center(
      child: Scaffold(
        key: _key,
        endDrawerEnableOpenDragGesture: false,
        endDrawer: SafeArea(
          child: Drawer(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                Container(
                  color: kBlack,
                  width: double.infinity,
                  height: height,
                  child: DrawerHeader(
                    child: Text('Drawer Header'),
                  ),
                ),
                TagItems(
                  title: "장르",
                  genreTitle: GenreTitle.GENRE,
                ),
                TagItems(title: "연도", genreTitle: GenreTitle.YEAR)
              ],
            ),
          ),
        ),
        appBar: appBar,
        body: Column(
          children: [
            Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () => _key.currentState.openEndDrawer(),
                  color: Colors.purple,
                  iconSize: 20,
                ))
          ],
        ),
      ),
    );
  }
}

class TagItems extends StatefulWidget {
  final String title;
  final GenreTitle genreTitle;

  TagItems({this.title, this.genreTitle});

  @override
  _TagItemsState createState() => _TagItemsState();
}

class _TagItemsState extends State<TagItems> {
  bool isVisible = true;
  Map<String, String> genreMap;

  @override
  Widget build(BuildContext context) {
    genreMap = _getTagMap(title: widget.genreTitle);

    return Container(
      padding: EdgeInsets.only(right: 10, left: 10),
      color: Colors.blueGrey,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            color: Colors.blueGrey,
            height: 60,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Text(widget.title),
                  ),
                  Spacer(),
                  isVisible
                      ? Icon(Icons.arrow_drop_up_outlined)
                      : Icon(Icons.arrow_drop_down_outlined)
                ],
              ),
            ),
          ),
          Visibility(
            visible: isVisible,
            child: Container(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Column(
                  children: genreMap.entries.map((data) {
                String key = data.key;
                String value = data.value;
                return CategoryItem(
                  category: key,
                  categoryValue: value,
                );
              }).toList()),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, String> _getTagMap({GenreTitle title}) {
    switch (title) {
      case GenreTitle.GENRE:
        return genreList;
      case GenreTitle.YEAR:
        return getFourYearMapData();
      case GenreTitle.AIR_TYPE:
        return genreList;
      case GenreTitle.AIRING:
        return genreList;
    }
  }
}

class CategoryItem extends StatefulWidget {
  final String category;
  final String categoryValue;

  CategoryItem({this.category, this.categoryValue});

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  CategoryClickStatus categoryClickStatus = CategoryClickStatus.NONE;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _changeCategoryStatus(categoryClickStatus);
        // BlocProvider.of<GenreSearchBloc>(context).add(GenreTest());
      },
      child: Container(
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(widget.category),
            ),
            Spacer(),
            _changeCategoryIcon(categoryClickStatus)
          ],
        ),
      ),
    );
  }

  _changeCategoryStatus(CategoryClickStatus status) {
    setState(() {
      switch (status) {
        case CategoryClickStatus.INCLUDE:
          categoryClickStatus = CategoryClickStatus.EXCLUDE;
          break;
        case CategoryClickStatus.EXCLUDE:
          categoryClickStatus = CategoryClickStatus.NONE;
          break;
        case CategoryClickStatus.NONE:
          categoryClickStatus = CategoryClickStatus.INCLUDE;
          break;
      }
    });
  }

  _changeCategoryIcon(CategoryClickStatus status) {
    switch (status) {
      case CategoryClickStatus.INCLUDE:
        return Icon(Icons.check_box);
      case CategoryClickStatus.EXCLUDE:
        return Icon(Icons.indeterminate_check_box_outlined);
      case CategoryClickStatus.NONE:
        return Icon(Icons.check_box_outline_blank);
    }
  }
}
