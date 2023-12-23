import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kontent/cms/cms_request.dart';
import 'package:kontent/entities/carousel.dart';
import 'package:kontent/kontentWidgets/kontent_carousel.dart';
import 'package:kontent/entities/page.dart' as kontent_page;

class KontentSelectedPageBodyWidget extends StatelessWidget {
  final String idPage;
  const KontentSelectedPageBodyWidget({super.key, required this.idPage});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPage(idPage),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            //in attesa
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            //errore
            print(
                'Si è verificato un errore durante la richiesta: ${snapshot.error}');
            return const Center(
              child: Text('Errore durante la richiesta della pagina',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            print('Pagina inesistente');
            return const Center(
                child: Text('Pagina inesistente',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)));
          }

          kontent_page.Page page = snapshot.data!;
          List<KontentCarouselWrapper> carousels = [];
          for (Carousel carousel in page.getCarousels) {
            carousels.add(KontentCarouselWrapper(carousel: carousel));
          }

          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: carousels,
              ),
            ),
          );
        });
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:kontent/cms/cms_request.dart';
// import 'package:kontent/entities/carousel.dart';
// import 'package:kontent/entities/page.dart' as kontent_page;
// import 'package:kontent/kontentWidgets/kontent_carousel.dart';

// class KontentSelectedPageBodyWidget extends StatefulWidget {
//   final String idPage;
//   const KontentSelectedPageBodyWidget({Key? key, required this.idPage})
//       : super(key: key);

//   @override
//   _KontentSelectedPageBodyWidgetState createState() =>
//       _KontentSelectedPageBodyWidgetState();
// }

// class _KontentSelectedPageBodyWidgetState
//     extends State<KontentSelectedPageBodyWidget> with WidgetsBindingObserver {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance?.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       SystemChrome.setPreferredOrientations([
//         DeviceOrientation.portraitUp,
//         DeviceOrientation.portraitDown,
//         DeviceOrientation.landscapeLeft,
//         DeviceOrientation.landscapeRight,
//       ]);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: getPage(widget.idPage),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             //in attesa
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             //errore
//             print(
//                 'Si è verificato un errore durante la richiesta: ${snapshot.error}');
//             return const Center(
//               child: Text('Errore durante la richiesta della pagina',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
//             );
//           } else if (!snapshot.hasData || snapshot.data == null) {
//             print('Pagina inesistente');
//             return const Center(
//                 child: Text('Pagina inesistente',
//                     style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 30)));
//           }

//           kontent_page.Page page = snapshot.data!;
//           List<KontentCarouselWrapper> carousels = [];
//           for (Carousel carousel in page.getCarousels) {
//             carousels.add(KontentCarouselWrapper(carousel: carousel));
//           }

//           return Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: carousels,
//               ),
//             ),
//           );
//         });
//   }
// }
