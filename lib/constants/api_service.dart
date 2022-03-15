import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:wiki_movie/constants/env_keys.dart';
import 'package:wiki_movie/model/cast.dart';
import 'package:wiki_movie/model/genre.dart';
import 'package:wiki_movie/model/movie.dart';
import 'package:wiki_movie/model/movie_detail.dart';
import 'package:wiki_movie/model/movie_ss.dart';

class APIService {
  final String baseUrl = "https://api.themoviedb.org/3";
  var client = http.Client();
  EnvKeys envs = EnvKeys();
  final apiKey = EnvKeys().tmdbKey.toString();
//Now Playing
  Future<List<Movie>> fetchNowPlaying() async {
    Random random = Random();
    int randomNumber = random.nextInt(10) + 1;

    try {
      String url =
          '$baseUrl/movie/now_playing?page=$randomNumber&api_key=$apiKey';
      final response = await client.get(Uri.parse(url));
      var movies = jsonDecode(response.body)['results'] as List;
      return movieFromJson(jsonEncode(movies));
    } catch (error, stake) {
      throw Exception('Error - $error with trace : $stake');
    }
  }

//Trending Movie Of The week
  Future<List<Movie>> fetchTrendingMovieOfDay() async {
    Random random = Random();
    int randomNumber = random.nextInt(100) + 1;
    try {
      String url =
          '$baseUrl/trending/movie/day?page=$randomNumber&api_key=$apiKey';

      final response = await client.get(Uri.parse(url));
      var movies = jsonDecode(response.body)['results'] as List;
      return movieFromJson(jsonEncode(movies));
    } catch (error, stake) {
      throw Exception('Error - $error with trace : $stake');
    }
  }

  Future<List<Movie>> fetchTopRated() async {
    Random random = Random();
    int randomNumber = random.nextInt(100) + 1;
    try {
      String url =
          '$baseUrl/discover/movie?vote_average.gte=9&page=$randomNumber&primary_release_date.gte=2020&api_key=$apiKey';
      final response = await client.get(Uri.parse(url));
      var movies = jsonDecode(response.body)['results'] as List;
      return movieFromJson(jsonEncode(movies));
    } catch (error, stake) {
      throw Exception('Error - $error with trace : $stake');
    }
  }

  //Genre - Category
  Future<List<Genre>> fetchGenreList() async {
    try {
      String url = '$baseUrl/genre/movie/list?api_key=$apiKey';
      final response = await client.get(Uri.parse(url));
      var genres = jsonDecode(response.body)['genres'] as List;
      return genreFromJson(jsonEncode(genres));
    } catch (error, stake) {
      throw Exception('Error - $error with trace : $stake');
    }
  } // Movie With Category

  Future<List<Movie>> fetchMovieByGenre(int genreId) async {
    try {
      String url =
          '$baseUrl/discover/movie?with_genres=$genreId&api_key=$apiKey';
      final response = await client.get(Uri.parse(url));
      var movies = jsonDecode(response.body)['results'] as List;
      return movieFromJson(jsonEncode(movies));
    } catch (error, stake) {
      throw Exception('Error - $error with trace : $stake');
    }
  }

  Future<MovieDesc> fetchMovieDetail(int movieId) async {
    try {
      String url = '$baseUrl/movie/$movieId?&api_key=$apiKey';
      final response = await client.get(Uri.parse(url));
      MovieDesc movieDesc = MovieDesc.fromJson(jsonDecode(response.body));
      movieDesc.images = await fetchMovieImages(movieId);
      movieDesc.cast = await fetchMovieCast(movieId);
      movieDesc.trailerId = await fetchYoutubeUrl(movieId);
      return movieDesc;
    } catch (error, stake) {
      throw Exception('Error - $error with trace : $stake');
    }
  }

  Future<MovieImage> fetchMovieImages(int movieId) async {
    try {
      String url = '$baseUrl/movie/$movieId/images?&api_key=$apiKey';
      final response = await client.get(Uri.parse(url));
      MovieImage movieImages = MovieImage.fromJson(jsonDecode(response.body));
      return movieImages;
    } catch (error, stake) {
      throw Exception('Error - $error with trace : $stake');
    }
  }

  Future<List<Cast>> fetchMovieCast(int movieId) async {
    try {
      String url = '$baseUrl/movie/$movieId/credits?&api_key=$apiKey';
      final response = await client.get(Uri.parse(url));
      var castList = jsonDecode(response.body)['cast'] as List;
      return castFromJson(jsonEncode(castList));
    } catch (error, stake) {
      throw Exception('Error - $error with trace : $stake');
    }
  }

  Future<String> fetchYoutubeUrl(int movieId) async {
    try {
      String url = '$baseUrl/movie/$movieId/videos?&api_key=$apiKey';
      final response = await client.get(Uri.parse(url));
      var list = jsonDecode(response.body)['results'] as List;
      var youtubeId = list.isEmpty ? " " : list[0]['key'];
      return youtubeId;
    } catch (error, stake) {
      throw Exception('Error - $error with trace : $stake');
    }
  }
}
