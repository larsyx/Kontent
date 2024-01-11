import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kontent/main.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class KontentVideoPlayer extends StatefulWidget {
  final String? videoUrl;

  const KontentVideoPlayer({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  State<KontentVideoPlayer> createState() => KontentVideoPlayerState();
}

class KontentVideoPlayerState extends State<KontentVideoPlayer>
    with RouteAware {
  late final player = Player();
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    // Play a [Media] or [Playlist].
    player.open(Media(widget.videoUrl!));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    player.dispose();
    super.dispose();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 9.0 / 16.0,
          child: MaterialVideoControlsTheme(
            normal: MaterialVideoControlsThemeData(
              topButtonBar: [
                MaterialCustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
              ],
            ),
            fullscreen: kDefaultMaterialVideoControlsThemeDataFullscreen,
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
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}
