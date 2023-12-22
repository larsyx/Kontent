import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kontent/main.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:media_kit_video/media_kit_video_controls/src/controls/methods/video_state.dart';

class KontentVideoPlayer extends StatefulWidget {
  const KontentVideoPlayer({Key? key}) : super(key: key);
  @override
  State<KontentVideoPlayer> createState() => KontentVideoPlayerState();
}

class KontentVideoPlayerState extends State<KontentVideoPlayer>
    with RouteAware {
  // Create a [Player] to control playback.
  late final player = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    // Play a [Media] or [Playlist].
    player.open(Media(
        'https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4'));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 9.0 / 16.0,
          child: MaterialVideoControlsTheme(
            normal: MaterialVideoControlsThemeData(
              // controlsHoverDuration: const Duration(seconds: 100),
              // buttonBarButtonSize: 24.0,
              // buttonBarButtonColor: Colors.white,
              topButtonBar: [
                MaterialCustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ],
            ),
            fullscreen: MaterialVideoControlsThemeData(
              displaySeekBar: false,
              topButtonBar: [
                MaterialCustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ],
              automaticallyImplySkipNextButton: false,
              automaticallyImplySkipPreviousButton: false,
            ),
            child: Scaffold(
              body: Video(
                controller: controller,
              ),
            ),
          )),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPush() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void didPop() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}
