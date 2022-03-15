import 'dart:convert';

List<MovieImage> movieImageFromJson(String str) =>
    List<MovieImage>.from(json.decode(str).map((x) => MovieImage.fromJson(x)));

String movieImageToJson(List<MovieImage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MovieImage {
  MovieImage({
    this.posters,
    this.backdrops,
  });

  List<dynamic>? posters;
  List<dynamic>? backdrops;

  factory MovieImage.fromJson(Map<String, dynamic> json) {
    return MovieImage(
      posters: List<dynamic>.from(json["posters"].map((x) => x)),
      backdrops: List<dynamic>.from(json["backdrops"].map((x) => x)),
    );
  }
  Map<String, dynamic> toJson() => {
        "posters": List<dynamic>.from(posters!.map((x) => x)),
        "backdrops": List<dynamic>.from(backdrops!.map((x) => x)),
      };
}
