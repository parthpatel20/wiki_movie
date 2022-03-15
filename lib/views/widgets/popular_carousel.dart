import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wiki_movie/controller/movie_controller.dart';
import 'package:wiki_movie/model/movie.dart';
import 'package:wiki_movie/views/widgets/fullwidth_card.dart';
import 'package:wiki_movie/views/widgets/title_text_red.dart';
import 'package:get/get.dart';

class PopularCarousel extends StatelessWidget {
  const PopularCarousel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MovieController movieController = Get.find<MovieController>();
    return Obx(() {
      return movieController.nowPlayingMovies.isEmpty
          ? CupertinoActivityIndicator()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textTitleRed(title: "Now Playing", fontSize: 25),
                      IconButton(
                          splashRadius: 20.0,
                          color: Colors.red,
                          onPressed: () {
                            Get.isDarkMode
                                ? Get.changeTheme(ThemeData.light())
                                : Get.changeTheme(ThemeData.dark());
                          },
                          icon: Icon(
                              MediaQuery.of(context).platformBrightness ==
                                      Brightness.dark
                                  ? Icons.brightness_2_outlined
                                  : Icons.brightness_2_sharp)),
                    ],
                  ),
                ),
                CarouselSlider.builder(
                  itemCount: movieController.nowPlayingMovies.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    Movie movie = movieController.nowPlayingMovies[itemIndex];
                    return fullWidthMovieCard(movie, context, movieController);
                  },
                  options: CarouselOptions(
                      reverse: false,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      pauseAutoPlayOnTouch: true,
                      pauseAutoPlayOnManualNavigate: true),
                )
              ],
            );
    });
  }
}
