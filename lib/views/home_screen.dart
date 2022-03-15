import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:wiki_movie/controller/genre_controller.dart';
import 'package:wiki_movie/controller/movie_controller.dart';
import 'package:wiki_movie/views/widgets/genre_tablist.dart';
import 'package:wiki_movie/views/widgets/movie_of_day.dart';
import 'package:wiki_movie/views/widgets/popular_carousel.dart';
import 'package:wiki_movie/views/widgets/top_rated.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final MovieController movieController = Get.put(MovieController());
  final GenreController genreController = Get.put(GenreController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   title: Text(
      //     "Movies",
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   centerTitle: true,
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PopularCarousel(),
            GenreTabList(),
            MovieOFDay(),
            TopRatedMovie()
          ],
        ),
      ),
    );
  }
}
