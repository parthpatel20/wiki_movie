import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiki_movie/controller/movie_controller.dart';
import 'package:wiki_movie/model/movie.dart';

import '../movie_detail.dart';

Widget fullWidthMovieCard(
    Movie movie, BuildContext context, MovieController _movieController) {
  return GestureDetector(
    onTap: () async {
      await _movieController.getMovieDetail(movie);
      Get.to(MovieDetailScreen());
    },
    child: Stack(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.bottomLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          child: CachedNetworkImage(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
            alignment: Alignment.center,
            imageUrl:
                "https://image.tmdb.org/t/p/original/${movie.backdropPath}",
            placeholder: (context, url) => Platform.isIOS
                ? CupertinoActivityIndicator()
                : SizedBox(
                    child: CircularProgressIndicator(),
                    height: 10.0,
                    width: 10.0,
                  ),
            errorWidget: (context, url, error) => CachedNetworkImage(
              imageUrl:
                  "https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    movie.title.toUpperCase(),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow),
                    Text(
                      movie.voteAverage.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ],
    ),
  );
}
