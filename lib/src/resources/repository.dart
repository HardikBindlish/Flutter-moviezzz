import 'api_provider.dart';
import 'package:moviezzz/src/models/item_model.dart';

class Repository{
  ApiProvider apiProvider = ApiProvider();

  Future<List<Movie>> fetchRData(data) async{
    return apiProvider.fetchRecentData(data);
  }

  Future<List<Movie>> fetchTData(data) async{
    return apiProvider.fetchTopRatedData(data);
  }

  Future<List<Genre>> fetchGenres() async{
    return apiProvider.fetchGenre();
  }

  Future<List<Movie>> search() async{
    return apiProvider.searchMovies();
  }
}