class Details{
  Movie movieDetail;
  List<Movie> similarMovies;

  Details({this.movieDetail, this.similarMovies});

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        movieDetail: Movie.fromJson(json["movie_detail"]),
        similarMovies: List<Movie>.from(json["similar_movies"].map((x) => Movie.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "movie_detail": movieDetail.toJson(),
        "similar_movies": List<dynamic>.from(similarMovies.map((x) => x.toJson())),
    };
}

class Movies {
  List<Movie> recent;
  List<Movie> topRated;
  List<Genre> genres;

  Movies({this.recent, this.topRated, this.genres});

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
    if (json['genres'] != null) {
      genres = new List<Genre>();
      json['genres'].forEach((v) {
        genres.add(new Genre.fromJson(v));
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
    if (this.genres != null) {
      data['genres'] = this.genres.map((v) => v.toJson()).toList();
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
  String category;
  String createDate;
  String trailer;
  String type;
  List<Episode> episode;

  Movie(
      {this.id,
      this.title,
      this.story,
      this.releaseDate,
      this.genre,
      this.rating,
      this.image,
      this.category,
      this.createDate,
      this.trailer,
      this.type,
      this.episode});

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
    category = json['category'];
    createDate = json['create_date'];
    trailer = json['trailer'];
    type = json['type'];
    if (json['episode'] != null) {
      episode = new List<Episode>();
      json['episode'].forEach((v) {
        episode.add(new Episode.fromJson(v));
      });
    }
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
    data['category'] = this.category;
    data['create_date'] = this.createDate;
    data['trailer'] = this.trailer;
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

class Episode {
  int id;
  String title;
  String download;
  String downloadSize;
  String quality;
  String length;
  int movies;

  Episode({this.id, this.title, this.download, this.downloadSize, this.quality, this.length, this.movies});

  Episode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    download = json['download'];
    downloadSize = json['download_size'];
    quality = json['quality'];
    length = json['length'];
    movies = json['movies'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['download'] = this.download;
    data['downloadSize'] = this.downloadSize;
    data['quality'] = this.quality;
    data['length'] = this.length;
    data['movies'] = this.movies;
    return data;
  } 
}