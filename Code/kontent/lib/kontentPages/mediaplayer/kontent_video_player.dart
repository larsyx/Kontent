import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ima_player/ima_player.dart';
import 'package:kontent/main.dart';
import 'package:media_kit_video/media_kit_video_controls/src/controls/material.dart';

class KontentVideoPlayer extends StatefulWidget {
  final String? videoUrl;

  const KontentVideoPlayer({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  State<KontentVideoPlayer> createState() => KontentVideoPlayerState();
}

class KontentVideoPlayerState extends State<KontentVideoPlayer> {
  var position = ValueNotifier(Duration.zero);
  var events = <AdEventType>[];

  final controller = ImaPlayerController.network(
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4',
    imaTag:
        'https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_preroll_skippable&sz=640x480&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=',
    options: const ImaPlayerOptions(
      autoPlay: true,
      initialVolume: 1.0,
      isMixWithOtherMedia: false,
      showPlaybackControls: false,
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 9.0 / 16.0,
      child: ImaPlayerUI(
          player: ImaPlayer(ImaPlayerController.network(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4',
        imaTag:
            'https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_preroll_skippable&sz=640x480&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=',
        options: const ImaPlayerOptions(
          autoPlay: true,
          initialVolume: 1.0,
          isMixWithOtherMedia: false,
          showPlaybackControls: false,
        ),
      ))),
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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

// trying to adjust play of .mpd with ima, not working yet


// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:ima_player/ima_player.dart';
// import 'package:kontent/main.dart';
// import 'package:media_kit/media_kit.dart';
// import 'package:media_kit_video/media_kit_video.dart';

// class KontentVideoPlayer extends StatefulWidget {
//   final String? videoUrl;

//   const KontentVideoPlayer({Key? key, required this.videoUrl})
//       : super(key: key);

//   @override
//   State<KontentVideoPlayer> createState() => KontentVideoPlayerState();
// }

// class KontentVideoPlayerState extends State<KontentVideoPlayer>
//     with RouteAware {
//   late final player = Player();
//   late final controller = VideoController(player);
//   late final imaController = ImaPlayerController.network(
//     '',
//     imaTag:
//         'https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_preroll_skippable&sz=640x480&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=',
//     options: const ImaPlayerOptions(
//       autoPlay: true,
//       initialVolume: 1.0,
//       isMixWithOtherMedia: false,
//       showPlaybackControls: false,
//     ),
//   );
//   var _adCompleted = false;

//   @override
//   void initState() {
//     super.initState();
//     // Listen for the end of the ad and then play the actual video.
//     imaController.onAdEvent.listen((AdEventType event) {
//       if (event == AdEventType.completed || event == AdEventType.skipped) {
//         player.open(Media(widget.videoUrl!));
//         setState(() {
//           _adCompleted = true;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     routeObserver.unsubscribe(this);
//     player.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SizedBox(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.width * 9.0 / 16.0,
//           child: MaterialVideoControlsTheme(
//             normal: MaterialVideoControlsThemeData(
//               topButtonBar: [
//                 MaterialCustomButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: const Icon(Icons.arrow_back_ios_new),
//                 ),
//               ],
//             ),
//             fullscreen: kDefaultMaterialVideoControlsThemeDataFullscreen,
//             child: Scaffold(
//               body: _adCompleted
//                   ? Video(controller: controller)
//                   : ImaPlayerUI(player: ImaPlayer(imaController)),
//             ),
//           )),
//     );
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     routeObserver.subscribe(this, ModalRoute.of(context)!);
//   }

//   @override
//   void didPush() async {
//     await SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//   }

//   @override
//   void didPop() async {
//     await SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//   }
// }
