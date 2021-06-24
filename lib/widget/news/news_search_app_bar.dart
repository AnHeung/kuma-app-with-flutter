import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/news/animation_news_bloc.dart';
import 'package:kuma_flutter_app/widget/common/base_app_bar.dart';
import 'package:kuma_flutter_app/widget/common/custom_text.dart';

class NewsSearchAppbar extends BaseAppbar {

  NewsSearchAppbar({Key key, this.queryCallback}):super(key: key);

  final Function(String) queryCallback;

  @override
  _NewsSearchAppbarState createState() => _NewsSearchAppbarState();
}

class _NewsSearchAppbarState extends State<NewsSearchAppbar>{

  TextEditingController _controller;
  bool isClick = false;
  final Widget TitleText = CustomText(
    text: "뉴스",
    fontSize: 20.0,
    fontColor: kWhite,
    fontFamily: doHyunFont,
    textAlign: TextAlign.center,
  );

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget titleTextField = Container(
      child: TextField(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 20),
          hintText: '검색어를 입력해주세요...',
          hintStyle: const TextStyle(color: kWhite),
        ),
        onChanged: (text) {
          widget.queryCallback(text);
          BlocProvider.of<AnimationNewsBloc>(context)
              .add(AnimationNewsSearch(query: text));
        },
        style: const TextStyle(color: kWhite),
        cursorColor: kWhite,
        autofocus: true,
        controller: _controller,
      ),
    );

    return AppBar(
      centerTitle: true,
      actions: [
        Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    isClick = !isClick;
                  });
                  if (isClick) {
                    _controller?.clear();
                  } else {
                    BlocProvider.of<AnimationNewsBloc>(context).add(AnimationNewsClear());
                    widget.queryCallback("");
                  }
                },
                icon: Icon(!isClick ? Icons.search : Icons.clear)))
      ],
      title: !isClick ? TitleText : titleTextField,
    );
  }
}