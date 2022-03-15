import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiki_movie/controller/movie_controller.dart';
import 'package:wiki_movie/model/movie.dart';
import 'package:wiki_movie/views/movie_detail.dart';

class PosterCards extends StatelessWidget {
  const PosterCards({Key? key, required this.movieList}) : super(key: key);
  final List<Movie> movieList;
  @override
  Widget build(BuildContext context) {
    var isPotrait = MediaQuery.of(context).orientation == Orientation.portrait;
    int widthVal = (Platform.isIOS || Platform.isAndroid) && isPotrait ? 2 : 4;
    int heigthVal = isPotrait ? 4 : 2;
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      height: MediaQuery.of(context).size.height / heigthVal + 50,
      child: ListView.separated(
        separatorBuilder: (context, index) => VerticalDivider(
          color: Colors.transparent,
          width: 5,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          Movie movie = movieList[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  MovieController _movieController =
                      Get.find<MovieController>();
                  _movieController.getMovieDetail(movie);
                  Get.to(MovieDetailScreen());
                },
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/original/${movie.posterPath}',
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        width: MediaQuery.of(context).size.width / widthVal,
                        height: MediaQuery.of(context).size.height / heigthVal,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                    placeholder: (context, url) => Container(
                      decoration: BoxDecoration(color: Colors.transparent),
                      width: MediaQuery.of(context).size.width / widthVal,
                      height: MediaQuery.of(context).size.height / 4,
                      child: Center(
                        child: Platform.isIOS
                            ? CupertinoActivityIndicator()
                            : Container(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: MediaQuery.of(context).size.width / widthVal,
                      height: MediaQuery.of(context).size.height / 4,
                      child: CachedNetworkImage(
                        imageUrl:
                            "http://www.movienewsletters.net/photos/000000H1.jpg",
                        fit: BoxFit.fill,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(color: Colors.transparent),
                width: MediaQuery.of(context).size.width / widthVal,
                child: Text(
                  movie.title.toUpperCase(),
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'muli',
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
