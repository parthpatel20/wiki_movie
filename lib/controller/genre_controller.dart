import 'package:get/state_manager.dart';
import 'package:wiki_movie/constants/api_service.dart';
import 'package:wiki_movie/model/genre.dart';
import 'package:wiki_movie/model/movie.dart';

class GenreController extends GetxController {
  RxList<Genre> genreList = RxList<Genre>();
  var selectedGenre = Genre().obs;
  RxList<Movie> moviesByGenre = <Movie>[].obs;
  APIService apiService = APIService();
  @override
  void onInit() async {
    super.onInit();
    await getGenreList();
  }

  Future<void> getGenreList() async {
    try {
      genreList.clear();
      var gList = await apiService.fetchGenreList();
      if (gList.isNotEmpty) {
        genreList.addAll(gList);
        selectedGenre.value = Genre(id: gList[0].id, name: gList[0].name);
        await selectGenreFromList(selectedGenre.value);
      }
    } finally {}
  }

  Future<void> selectGenreFromList(Genre genre) async {
    try {
      selectedGenre.value = genre;

      moviesByGenre.clear();
      var movieList = await apiService.fetchMovieByGenre(genre.id!);
      if (movieList.isNotEmpty) {
        moviesByGenre.addAll(movieList);
      }
    } finally {}
  }
}
