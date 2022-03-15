import 'dart:async';

import 'package:get/state_manager.dart';
import 'package:wiki_movie/constants/api_service.dart';
import 'package:wiki_movie/model/movie.dart';

class MovieController extends GetxController {
  RxList<Movie> nowPlayingMovies = RxList<Movie>();
  RxList<Movie> moviesOfTheWeek = RxList<Movie>();
  RxList<Movie> topRatedMovies = RxList<Movie>();
  APIService apiService = APIService();
  var selectedMovie = {}.obs;
  var movieDescription = {}.obs;
  @override
  void onInit() async {
    super.onInit();
    await getNowPlaying();
    await getTrendingMovieOfTheWeek();
    await getTopRated();
  }

  Future<void> getNowPlaying() async {
    try {
      nowPlayingMovies.clear();
      var npList = await apiService.fetchNowPlaying();
      if (npList.isNotEmpty) {
        nowPlayingMovies.addAll(npList);
      }
    } finally {}
  }

  Future<void> getTrendingMovieOfTheWeek() async {
    try {
      moviesOfTheWeek.clear();
      var npList = await apiService.fetchTrendingMovieOfDay();
      if (npList.isNotEmpty) {
        moviesOfTheWeek.addAll(npList);
      }
    } finally {}
  }

  Future<void> getTopRated() async {
    try {
      topRatedMovies.clear();
      var npList = await apiService.fetchTopRated();
      if (npList.isNotEmpty) {
        topRatedMovies.addAll(npList);
      }
    } finally {}
  }

  Future<void> getMovieDetail(Movie movie) async {
    try {
      selectedMovie.value = {};
      movieDescription.value = {};
      var md = await apiService.fetchMovieDetail(movie.id);
      selectedMovie.value = movie.toJson();
      movieDescription.value = md.toJson();
    } finally {}
  }
}
