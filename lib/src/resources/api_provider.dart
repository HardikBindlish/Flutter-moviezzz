import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:moviezzz/src/models/item_model.dart';


class ApiProvider{
  Client client = Client();

  Future<List<Movie>> fetchRecentMovies() async{
    final response = await client.get('http://harsh4861.pythonanywhere.com/api/fetch/?type=M');
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      List<Movie> recent = Movies.fromJson(data).recent;
      return recent;
    }
    else{
      throw Exception('Falied to get movies list');
    }
  }

  Future<List<Movie>> fetchTopRatedMovies() async{
    final response = await client.get('http://harsh4861.pythonanywhere.com/api/fetch/?type=M');
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      List<Movie> topRated = Movies.fromJson(data).topRated; 
      return topRated; 
    }
    else{
      throw Exception('Falied to get movies list');
    }
  }
  
  Future<List<Movie>> fetchRecentSeasons() async{
    final response = await client.get('http://harsh4861.pythonanywhere.com/api/fetch/?type=S');
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      List<Movie> recent = Movies.fromJson(data).recent;
      return recent;
    }
    else{
      throw Exception('Falied to get movies list');
    }
  }

  Future<List<Movie>> fetchTopRatedSeasons() async{
    final response = await client.get('http://harsh4861.pythonanywhere.com/api/fetch/?type=S');
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

  Future<List<Movie>> fetchGenreViseMovies(int id) async{
    final response = await client.get('http://harsh4861.pythonanywhere.com/api/fetch/?type=M&genre=$id');
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      List<Movie> recent = Movies.fromJson(data).recent;
      return recent; 
    }
    else{
      throw Exception('Falied to get movies list');
    }
  }
}