import 'package:http/http.dart' as http;
import 'package:kontent/entities/carousel.dart';
import 'package:kontent/entities/content.dart';
import 'dart:convert';
import 'package:kontent/entities/page.dart';

final headers = {
  'Application': 'feb7a85ece0ad8a76fa5bad1780d3d37',
  'Authorization':
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYXBwLWNoYWxsZW5nZS0yMDIzLTI0IiwiZXhwIjoxNzAyOTc3MDExLCJpc3MiOiIxMyIsImlhdCI6MTcwMjg5MDYxMX0.nH4YFG-EOvTvVncJ5yvApV_5lFHbRr9ukDhVBoTJLIs'
};

Future<Page?> getPage(String page) async {
  var parameters = {'data': 'mngk', 'type': 'get-page', 'id': page};

  var url =
      Uri.http('wpdev.kinedev.it', '/wp-content/api/getApi2.php', parameters);

  var response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonMap = jsonDecode(response.body);
    var page = Page.fromJson(jsonMap['data']);
    return page;
  } else {
    return null;
  }
}

Future<Carousel?> getCarousel(String page, String idCarousel) async {
  var parameters = {'data': 'mngk', 'type': 'get-page', 'id': page};

  var url =
      Uri.http('wpdev.kinedev.it', '/wp-content/api/getApi2.php', parameters);

  var response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonMap = jsonDecode(response.body);
    Map<String, dynamic> data = jsonMap['data'];
    List<Map<String, dynamic>> content = data['content']
        .map<Map<String, dynamic>>((item) => item as Map<String, dynamic>)
        .toList();

    Map<String, dynamic>? collection1;
    for (Map<String, dynamic> item in content) {
      if (item['id'] == idCarousel) {
        collection1 = item;
        break;
      }
    }

    if (collection1 != null) {
      var carousel = Carousel.fromJson(collection1);
      return carousel;
    } else {
      return null;
    }
  } else {
    return null;
  }
}

Future<Content?> getContent(
    String page, String idCarousel, String idContent) async {
  var parameters = {'data': 'mngk', 'type': 'get-page', 'id': page};

  var url =
      Uri.http('wpdev.kinedev.it', '/wp-content/api/getApi2.php', parameters);

  var response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonMap = jsonDecode(response.body);
    Map<String, dynamic> data = jsonMap['data'];
    List<Map<String, dynamic>> content = data['content']
        .map<Map<String, dynamic>>((item) => item as Map<String, dynamic>)
        .toList();

    Map<String, dynamic>? collection;
    for (Map<String, dynamic> item in content) {
      if (item['id'] == idCarousel) {
        collection = item;
        break;
      }
    }
    if (collection != null) {
      List<Map<String, dynamic>>? contents = collection['items']
          .map<Map<String, dynamic>>((item) => item as Map<String, dynamic>)
          .toList();

      Map<String, dynamic>? contentJson;
      if (contents != null) {
        for (Map<String, dynamic> item in contents) {
          if (item['id'] == int.parse(idContent)) {
            contentJson = item;
            break;
          }
        }

        if (contentJson != null) {
          var content = Content.fromJson(contentJson);
          return content;
        }
      }
    }
    return null;
  } else {
    return null;
  }
}
