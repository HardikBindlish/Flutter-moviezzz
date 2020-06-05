import 'api_provider.dart';
import 'package:moviezzz/src/models/item_model.dart';

class Repository{
  ApiProvider apiProvider = ApiProvider();

  Future<List<Movie>> fetchRMovies() async{
    return apiProvider.fetchRecentMovies();
  }

  Future<List<Movie>> fetchTMovies() async{
    return apiProvider.fetchTopRatedMovies();
  }

  Future<List<Movie>> fetchRSeasons() async{
    return apiProvider.fetchRecentSeasons();
  }

  Future<List<Movie>> fetchTSeasons() async{
    return apiProvider.fetchTopRatedSeasons();
  }

  Future<List<Genre>> fetchGenres() async{
    return apiProvider.fetchGenre();
  }
}