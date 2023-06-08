import 'package:flutter/material.dart';
import 'package:flutter_application_kobis/movie_api.dart';

class MovieDetail extends StatefulWidget {
  String movieCd;

  MovieDetail({super.key, required this.movieCd});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  build(BuildContext context) async {
    var movieApi = MovieApi();
    var movie = await movieApi.searchDetail(moviecode: widget.movieCd);

    var movieTitle = movie['movieNm'];
    /* dynamic titleImage = movie['posters'].toString().isEmpty
        ? Image.asset('assets/images/no_image.png')
        : Image.network(movie['posters'].toString().split('|')[0]); */
    //var stills = movie['stlls'].toString().split('|');

    //만약 없으면 로컬 이미지
    //있으면 네트워크 이미지
    return Scaffold(
      appBar: AppBar(title: Text('영화 상세 정보($movieTitle)')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: Center(
                  child: Text(movieTitle,
                      style: const TextStyle(
                          fontSize: 50, fontWeight: FontWeight.bold)),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    '키워드 : ${movie['typeNm']}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
