import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:moviezzz/src/models/item_model.dart';

class ApiProvider{
  Client client = Client();

  Future<List<Movie>> fetchRecentData(Map data) async{
    var response;

    if(data['genre'] == null){
      response = await client.get('http://harsh4861.pythonanywhere.com/api/fetch?type=${data['type']}');
    } else {
      response = await client.get('http://harsh4861.pythonanywhere.com/api/fetch?type=${data['type']}&genre=${data['genre']}');
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
      response = await client.get('http://harsh4861.pythonanywhere.com/api/fetch?type=${data['type']}');
    } else {
      response = await client.get('http://harsh4861.pythonanywhere.com/api/fetch?type=${data['type']}&genre=${data['genre']}');
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
    final response = await client.get('http://harsh4861.pythonanywhere.com/api/genre/list');
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
    final response = await client.get('http://harsh4861.pythonanywhere.com/api/search');
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
}