import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/util/common.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayer extends StatefulWidget {

  final String url;
  final Key scaffoldKey;

  @override
  _YoutubePlayerState createState() => _YoutubePlayerState();

  YoutubeVideoPlayer({this.url , this.scaffoldKey});
}

class _YoutubePlayerState extends State<YoutubeVideoPlayer> with AutomaticKeepAliveClientMixin{

  YoutubePlayerController _controller;

  @override
  bool get wantKeepAlive => true;

  @override
  void didUpdateWidget(YoutubeVideoPlayer oldWidget) {
    if (oldWidget.url != widget.url) this.updateChildWithParent(widget.url);
    super.didUpdateWidget(oldWidget);
  }

  void updateChildWithParent(String url) {
    setState(() {
      _controller = _buildYoutubeController(url: widget.url);
    });
  }

  _buildYoutubeController({String url}){
    return YoutubePlayerController(
      initialVideoId: getVideoId(url),
      flags: const YoutubePlayerFlags(
        forceHD: true,
        autoPlay: false,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = _buildYoutubeController(url: widget.url);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        key: widget.scaffoldKey,
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          topActions: <Widget>[
            const Spacer(),
          ],
          bottomActions: [
            CurrentPosition(controller: _controller,),
            ProgressBar(isExpanded: true,),
            RemainingDuration(controller: _controller,),
            Container(padding: const EdgeInsets.only(right: 10), alignment: Alignment.center, child: PlaybackSpeedButton(controller: _controller,)),
          ],
        ),
        builder: (context, player) => Container(
            child: player,
          ),
    ) ;
  }
}