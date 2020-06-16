import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:moviezzz/src/models/item_model.dart';


class ApiProvider{
  Client client = Client();
  final url = 'http://3.128.25.203/api';

  Future<List<Movie>> fetchRecentData(Map data) async{
    var response;

    if(data['genre'] == null){
      response = await client.get('$url/fetch?type=${data['type']}');
    } else {
      response = await client.get('$url/fetch?type=${data['type']}&genre=${data['genre']}');
    }
    print("${data['type']} / ${data['genre']} ");
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      List<Movie> recent = Movies.fromJson(data).recent;
      return recent;
    }
    else{
      throw Exception('Falied to get movies list');
    }
  }

  Future<List<Movie>> fetchTopRatedData(Map data) async{
    var response;

    if(data['genre'] == null){
      response = await client.get('$url/fetch?type=${data['type']}');
    } else {
      response = await client.get('$url/fetch?type=${data['type']}&genre=${data['genre']}');
    }
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      List<Movie> topRated = Movies.fromJson(data).topRated;
      return topRated;
    }
    else{
      throw Exception('Falied to get movies list');
    }
  }

  Future<List<Movie>> fetchGenreRecentData(Map data) async{
    var response;

    if(data['genre'] == null){
      response = await client.get('$url/fetch?type=${data['type']}');
    } else {
      response = await client.get('$url/fetch?type=${data['type']}&genre=${data['genre']}');
    }
    print("${data['type']} / ${data['genre']} ");
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      List<Movie> recent = Movies.fromJson(data).recent;
      return recent;
    }
    else{
      throw Exception('Falied to get movies list');
    }
  }

  Future<List<Movie>> fetchGenreTopRatedData(Map data) async{
    var response;

    if(data['genre'] == null){
      response = await client.get('$url/fetch?type=${data['type']}');
    } else {
      response = await client.get('$url/fetch?type=${data['type']}&genre=${data['genre']}');
    }
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      List<Movie> topRated = Movies.fromJson(data).topRated;
      return topRated;
    }
    else{
      throw Exception('Falied to get movies list');
    }
  }

  Future<List<Genre>> fetchGenre() async{
    final response = await client.get('$url/genre/list');
    // print(response.body);
    if(response.statusCode == 200){
      final data = json.decode(response.body) as List;
      List<Genre> genres = List<Genre>();
      data.forEach((genre) => {genres.add(Genre.fromJson(genre))});
      return genres;
    }
    else{
      throw Exception('Falied to get movies list');
    }
  }

  Future<List<Movie>> searchMovies() async{
    final response = await client.get('$url/search');
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      List<Movie> search = List<Movie>();
      data.forEach((movie) => {search.add(Movie.fromJson(movie))});
      return search;
    }
    else{
      throw Exception('Falied to get movies list');
    }
  }

  Future<Movie> detailMovies(int id) async{
    final response = await client.get('$url/movie?id=$id');
    if(response.statusCode == 200){
      Map<String, dynamic> data = json.decode(response.body);
      Movie detail = Details.fromJson(data).movieDetail;
      return detail;
    }
    else{
      throw Exception('Falied to get movies list');
    }
  }

  Future<List<Movie>> similarMovies(int id) async{
    final response = await client.get('$url/movie?id=$id');
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      List<Movie> similar = Details.fromJson(data).similarMovies;
      return similar;
    }
    else{
      throw Exception('Falied to get movies list');
    }
  }
}