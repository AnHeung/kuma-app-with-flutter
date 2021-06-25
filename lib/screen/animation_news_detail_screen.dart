part of 'screen.dart';

class AnimationNewsDetailScreen extends StatelessWidget {

  final AnimationNewsItem newsItem;

  AnimationNewsDetailScreen(this.newsItem);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(newsItem.title),
      ),
      body:  Container(
        constraints: const BoxConstraints.expand(),
        color: kSoftPurple,
        child: WebViewContainer(
            url: newsItem.url,
        ),
      ),
    );
  }

}
