import 'dart:convert';

import 'package:http/http.dart' as http;

//http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=68e44fd6eab931b1a515299e75d9562e&targetDt=20120101
class MovieApi {
  final api_key = '68e44fd6eab931b1a515299e75d9562e';

  Future<List<dynamic>> search({required String date}) async {
    String site =
        'http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=$api_key&targetDt=$date';
    var response = await http.get(Uri.parse(site));
    if (response.statusCode == 200) {
      var movies = jsonDecode(response.body)['boxOfficeResult']
          ['dailyBoxOfficeList'] as List<dynamic>;
      print(response.body);
      return movies;
    } else {
      return [];
    }
  }

  Future<dynamic> searchDetail({required String moviecode}) async {
    String site =
        'http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=$api_key&movieCd=$moviecode';
    var response = await http.get(Uri.parse(site));
    print(response.body);
    if (response.statusCode == 200) {
      var movies =
          jsonDecode(response.body)['movieInfoResult']['movieInfo'] as dynamic;
      return movies;
    } else {
      return [];
    }
  }
}
