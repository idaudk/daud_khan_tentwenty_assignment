class MovieImages {
  List<Backdrops>? backdrops;
  int? id;
  List<Backdrops>? logos;
  List<Backdrops>? posters;

  MovieImages({this.backdrops, this.id, this.logos, this.posters});

  MovieImages.fromJson(Map<String, dynamic> json) {
    if (json['backdrops'] != null) {
      backdrops = <Backdrops>[];
      json['backdrops'].forEach((v) {
        backdrops!.add(new Backdrops.fromJson(v));
      });
    }
    id = json['id'];
    if (json['logos'] != null) {
      logos = <Backdrops>[];
      json['logos'].forEach((v) {
        logos!.add(Backdrops.fromJson(v));
      });
    }
    if (json['posters'] != null) {
      posters = <Backdrops>[];
      json['posters'].forEach((v) {
        posters!.add(Backdrops.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.backdrops != null) {
      data['backdrops'] = this.backdrops!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    if (this.logos != null) {
      data['logos'] = this.logos!.map((v) => v.toJson()).toList();
    }
    if (this.posters != null) {
      data['posters'] = this.posters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Backdrops {
  double? aspectRatio;
  int? height;
  String? iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  Backdrops(
      {this.aspectRatio,
      this.height,
      this.iso6391,
      this.filePath,
      this.voteAverage,
      this.voteCount,
      this.width});

  Backdrops.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso6391 = json['iso_639_1'];
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aspect_ratio'] = this.aspectRatio;
    data['height'] = this.height;
    data['iso_639_1'] = this.iso6391;
    data['file_path'] = this.filePath;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    data['width'] = this.width;
    return data;
  }
}
