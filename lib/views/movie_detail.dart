// ignore_for_file: prefer_is_empty

import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wiki_movie/controller/movie_controller.dart';
import 'package:wiki_movie/model/cast.dart';
import 'package:wiki_movie/model/movie_detail.dart';
import 'package:wiki_movie/model/movie_ss.dart';
import 'package:wiki_movie/model/screenshot.dart';
import 'package:wiki_movie/views/widgets/title_text_red.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MovieController _movieController = Get.find<MovieController>();
    Random random = Random();
    var isPotrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Obx(() {
      if (_movieController.movieDescription.isNotEmpty) {
        MovieDesc movieDescs =
            MovieDesc.fromJson(_movieController.movieDescription.toJson());
        MovieImage movieImages = _movieController.movieDescription['images'];
        List<Cast> movieCast = _movieController.movieDescription['cast'];
        ScreenShot posterImage = ScreenShot(filePath: "");
        if (movieImages.posters!.length > 0 &&
            movieImages.backdrops!.length > 0) {
          int randomNumber = random.nextInt(isPotrait
              ? movieImages.posters!.length
              : movieImages.backdrops!.length);
          posterImage = isPotrait
              ? ScreenShot.fromJson(movieImages.posters![randomNumber])
              : ScreenShot.fromJson(movieImages.backdrops![randomNumber]);
        }

        return Scaffold(
          body: CustomScrollView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                    background: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                  child: CachedNetworkImage(
                      imageUrl:
                          "https://image.tmdb.org/t/p/original/${posterImage.filePath}",
                      fit: BoxFit.fill,
                      errorWidget: (context, error, stackTrace) =>
                          Image.network(
                            "https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image.png",
                            fit: BoxFit.fill,
                          )),
                )),
                expandedHeight: isPotrait
                    ? MediaQuery.of(context).size.height / 2
                    : MediaQuery.of(context).size.height / 1.5,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movieDescs.title.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.justify,
                      ),
                      Center(
                        child: OutlinedButton.icon(
                          icon: Icon(Icons.play_arrow),
                          style: OutlinedButton.styleFrom(
                              minimumSize: Size(80, 50),
                              primary: Colors.red,
                              alignment: Alignment.center),
                          onPressed: () async {
                            final youtubeUrl =
                                'https://www.youtube.com/embed/${movieDescs.trailerId}';
                            if (await canLaunch(youtubeUrl)) {
                              await launch(youtubeUrl);
                            }
                          },
                          label: Text("Play Trailer"),
                        ),
                      ),
                      Text(movieDescs.overview.toString()),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              textTitleRed(title: "imdb"),
                              Text(movieDescs.imdbId.toString().toUpperCase()),
                            ],
                          ),
                          Column(
                            children: [
                              textTitleRed(title: "Rating"),
                              Text(movieDescs.voteAverage
                                  .toString()
                                  .toUpperCase()),
                            ],
                          ),
                          Column(
                            children: [
                              textTitleRed(title: "Release Date"),
                              Text(movieDescs.releaseDate
                                  .toString()
                                  .toUpperCase()),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          textTitleRed(title: "Languages"),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 1.4,
                            child: ListView.separated(
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Chip(
                                    label: Text(movieDescs
                                        .spokenLanguages![index].englishName
                                        .toString()));
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      VerticalDivider(
                                color: Colors.transparent,
                                width: 2,
                              ),
                              itemCount: movieDescs.spokenLanguages!.length,
                            ),
                          )
                        ],
                      ),
                      movieImages.backdrops!.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child:
                                  textTitleRed(title: "Photos", fontSize: 20),
                            )
                          : Container(),
                      movieCast.isNotEmpty
                          ? SizedBox(
                              height: isPotrait
                                  ? MediaQuery.of(context).size.height / 5
                                  : MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    ScreenShot backDropImage =
                                        ScreenShot.fromJson(
                                            movieImages.backdrops![index]);
                                    return backdropPosters(context,
                                        backDropImage.filePath.toString());
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          VerticalDivider(
                                            color: Colors.transparent,
                                            width: 2,
                                          ),
                                  itemCount: movieImages.backdrops!.length),
                            )
                          : Container(),
                      movieCast.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: textTitleRed(title: "Cast", fontSize: 20))
                          : Container(),
                      movieCast.isNotEmpty
                          ? SizedBox(
                              height: isPotrait
                                  ? MediaQuery.of(context).size.height / 4
                                  : MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    Cast actors = Cast.fromJson(
                                        movieCast[index].toJson());
                                    return castWidget(actors, context);
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          VerticalDivider(
                                            color: Colors.transparent,
                                            width: 2,
                                          ),
                                  itemCount: movieCast.length),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
      return Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      );
    });
  }
}

// Widget textTitleRed(String title) {
//   return Text(title.toUpperCase(),
//       style: TextStyle(
//         fontSize: 15,
//         fontWeight: FontWeight.bold,
//         color: Colors.redAccent,
//       ));
// }

Widget backdropPosters(BuildContext context, String urlpath) {
  return ClipRRect(
    clipBehavior: Clip.antiAlias,
    borderRadius: BorderRadius.all(Radius.circular(16)),
    child: CachedNetworkImage(
      fit: BoxFit.fill,
      alignment: Alignment.center,
      imageUrl: "https://image.tmdb.org/t/p/original/$urlpath",
      placeholder: (context, url) => CupertinoActivityIndicator(),
      errorWidget: (context, url, error) => CachedNetworkImage(
        imageUrl:
            "https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image.png",
        fit: BoxFit.fill,
      ),
    ),
  );
}

Widget castWidget(Cast cast, BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.amberAccent.withOpacity(0.5),
      borderRadius: BorderRadius.all(Radius.circular(50.0)),
      image: DecorationImage(
        image: NetworkImage(
            'https://image.tmdb.org/t/p/original/${cast.profilePath}'),
        fit: BoxFit.cover,
      ),
    ),
    width: MediaQuery.of(context).size.width / 3,
    child: Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              textTitleRed(
                  title:
                      cast.name.toString() + " as " + cast.character.toString(),
                  fontSize: 10),
            ]),
      ),
    ),
  );
}
