import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:wiki_movie/controller/movie_controller.dart';
import 'package:wiki_movie/views/widgets/poster_cards.dart';
import 'package:wiki_movie/views/widgets/title_text_red.dart';

class MovieOFDay extends StatelessWidget {
  const MovieOFDay({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final MovieController movieController = Get.find<MovieController>();
    return Obx(() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: textTitleRed(title: "Movie of the day", fontSize: 25),
        ),
        PosterCards(movieList: movieController.moviesOfTheWeek.toList())
      ]);
    });
  }
}
