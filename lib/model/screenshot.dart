import 'dart:convert';

List<ScreenShot> screenShotFromJson(String str) =>
    List<ScreenShot>.from(json.decode(str).map((x) => ScreenShot.fromJson(x)));

String screenShotToJson(List<ScreenShot> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScreenShot {
  ScreenShot({
    this.aspectRatio,
    this.height,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  double? aspectRatio;
  int? height;
  dynamic iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  factory ScreenShot.fromJson(Map<String, dynamic> json) => ScreenShot(
        aspectRatio: json["aspect_ratio"].toDouble(),
        height: json["height"],
        iso6391: json["iso_639_1"],
        filePath: json["file_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "aspect_ratio": aspectRatio,
        "height": height,
        "iso_639_1": iso6391,
        "file_path": filePath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "width": width,
      };
}
