class Movies {
  List<Movie> recent;
  List<Movie> topRated;

  Movies({this.recent, this.topRated});

  Movies.fromJson(Map<String, dynamic> json) {
    if (json['recent'] != null) {
      recent = new List<Movie>();
      json['recent'].forEach((v) {
        recent.add(new Movie.fromJson(v));
      });
    }
    if (json['top_rated'] != null) {
      topRated = new List<Movie>();
      json['top_rated'].forEach((v) {
        topRated.add(new Movie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recent != null) {
      data['recent'] = this.recent.map((v) => v.toJson()).toList();
    }
    if (this.topRated != null) {
      data['top_rated'] = this.topRated.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Movie {
  int id;
  String title;
  String story;
  String releaseDate;
  List<Genre> genre;
  String rating;
  String image;
  String download;
  String category;
  String createDate;
  String trailer;
  String downloadSize;
  String type;

  Movie(
      {this.id,
      this.title,
      this.story,
      this.releaseDate,
      this.genre,
      this.rating,
      this.image,
      this.download,
      this.category,
      this.createDate,
      this.trailer,
      this.downloadSize,
      this.type});

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    story = json['story'];
    releaseDate = json['release_date'];
    if (json['genre'] != null) {
      genre = new List<Genre>();
      json['genre'].forEach((v) {
        genre.add(new Genre.fromJson(v));
      });
    }
    rating = json['rating'];
    image = json['image'];
    download = json['download'];
    category = json['category'];
    createDate = json['create_date'];
    trailer = json['trailer'];
    downloadSize = json['download_size'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['story'] = this.story;
    data['release_date'] = this.releaseDate;
    if (this.genre != null) {
      data['genre'] = this.genre.map((v) => v.toJson()).toList();
    }
    data['rating'] = this.rating;
    data['image'] = this.image;
    data['download'] = this.download;
    data['category'] = this.category;
    data['create_date'] = this.createDate;
    data['trailer'] = this.trailer;
    data['download_size'] = this.downloadSize;
    data['type'] = this.type;
    return data;
  }
}

class Genre {
  int id;
  String genre;

  Genre({this.id, this.genre});

  Genre.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    genre = json['genre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['genre'] = this.genre;
    return data;
  }
}