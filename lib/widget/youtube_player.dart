import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/util/vaildate_util.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayer extends StatefulWidget {

  final String url;
  final Key scaffoldKey;

  @override
  _YoutubePlayerState createState() => _YoutubePlayerState();

  YoutubeVideoPlayer({this.url , this.scaffoldKey});
}

class _YoutubePlayerState extends State<YoutubeVideoPlayer> {

  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: getVideoId(widget.url),
      flags: const YoutubePlayerFlags(
        forceHD: true,
        autoPlay: false,
        mute: true,
      ),
    );
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
            IconButton(
              icon: const Icon(
                Icons.video_collection_outlined,
                color: Colors.white,
                size: 25.0,
              ),
              onPressed: () {
                print('Settings Tapped!');
              },
            ),
          ],
          bottomActions: [
            CurrentPosition(controller: _controller,),
            ProgressBar(isExpanded: true,),
            RemainingDuration(controller: _controller,),
            Container(padding: const EdgeInsets.only(right: 10), alignment: Alignment.center, child: PlaybackSpeedButton(controller: _controller,)),
          ],
        ),
        builder: (context, player) =>player
    );
  }
}