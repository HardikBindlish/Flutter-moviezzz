import 'api_provider.dart';
import 'package:moviezzz/src/models/item_model.dart';

class Repository{
  ApiProvider apiProvider = ApiProvider();

  Future<List<Movie>> fetchRMovies(data) async{
    return apiProvider.fetchRecentMovies(data);
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