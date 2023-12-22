import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kontent/entities/page.dart';

Future<Page?> getPage(String page) async {
  var headers = {
    'Application': 'feb7a85ece0ad8a76fa5bad1780d3d37',
    'Authorization':
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYXBwLWNoYWxsZW5nZS0yMDIzLTI0IiwiZXhwIjoxNzAyOTc3MDExLCJpc3MiOiIxMyIsImlhdCI6MTcwMjg5MDYxMX0.nH4YFG-EOvTvVncJ5yvApV_5lFHbRr9ukDhVBoTJLIs'
  };

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
