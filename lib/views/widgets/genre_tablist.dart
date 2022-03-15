import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:wiki_movie/controller/genre_controller.dart';
import 'package:wiki_movie/model/genre.dart';
import 'package:wiki_movie/views/widgets/poster_cards.dart';

class GenreTabList extends StatelessWidget {
  const GenreTabList({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GenreController genreController = Get.find<GenreController>();
    return Obx(() {
      Genre selectedG = genreController.selectedGenre.value;
      return Column(children: [
        Container(
          height: 80,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.transparent),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Genre genre = genreController.genreList[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        genreController.selectGenreFromList(genre);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.red,
                            ),
                            color: genre.id == selectedG.id
                                ? Colors.red
                                : Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Text(
                          genre.name.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: genre.id == selectedG.id
                                ? FontWeight.bold
                                : FontWeight.normal,
                            // color: genre.id == selectedG.id
                            //     ? Colors.white
                            //     : Colors.redAccent,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  VerticalDivider(color: Colors.transparent),
              itemCount: genreController.genreList.length),
        ),
        PosterCards(movieList: genreController.moviesByGenre.toList())
      ]);
    });
  }
}
