import 'package:flutter/material.dart';
import 'package:flutter_application_kobis/movie_api.dart';
import 'package:flutter_application_kobis/movie_form.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  dynamic body = const Center(
      child: Text(
    'Movies!',
    style: TextStyle(fontSize: 50),
  ));

  dynamic mealList = const Text('검색하세요');

  void showCal() async {
    var dt = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 1)),
      firstDate: DateTime(2023, 03, 02),
      lastDate: DateTime.now().subtract(const Duration(days: 1)),
      locale: const Locale('ko', 'KR'),
    );

    //2023-05-16 00:00:00.000 - 2023-05-20 00:00:00.000
    String selectedDate = dt.toString().split(' ')[0].replaceAll('-', '');
    MovieApi movieApi = MovieApi();
    var movies = movieApi.search(date: selectedDate);

    setState(() {
      body = FutureBuilder(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var movieData = snapshot.data;
            return ListView.separated(
                itemBuilder: (context, index) {
                  return Movie_Form(movie: movieData[index]);
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: movieData!.length); //!를 쓰면 movieData가 무조건 있다는 뜻
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );

      /* body = ListView.separated(
          itemBuilder: (context, index) {
            return Movie_Form(movie: movies[index]);
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: movies.length); */
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: body,
        floatingActionButton: FloatingActionButton(
          onPressed: showCal,
          child: const Icon(
            Icons.calendar_month_rounded,
          ),
        ));
  }
}
