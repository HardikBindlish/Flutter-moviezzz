import 'package:moviezzz/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:moviezzz/src/models/item_model.dart';

class MoviesBloc {
  Repository _repository = Repository();
  final _rmovies = BehaviorSubject<List<Movie>>();
  final _tmovies = BehaviorSubject<List<Movie>>();
  final _genres = BehaviorSubject<List<Genre>>();
  final _search = BehaviorSubject<List<Movie>>();

  Stream<List<Movie>> get rMovies => _rmovies.stream;
  Stream<List<Movie>> get tMovies => _tmovies.stream;
  Stream<List<Genre>> get genre => _genres.stream;
  Stream<List<Movie>> get sMovies => _search.stream;

  recentData(data) async {
    List<Movie> rmovie = await _repository.fetchRData(data);
    _rmovies.sink.add(rmovie);
  }

  topData(data) async {
    List<Movie> tmovie = await _repository.fetchTData(data);
    _tmovies.sink.add(tmovie);
  }

  allGenre() async {
    List<Genre> tseason = await _repository.fetchGenres();
    _genres.sink.add(tseason);
  }

  searchdata() async {
    List<Movie> smovie = await _repository.search();
    _search.sink.add(smovie);
  }

  dispose() {
    _rmovies.close();
    _tmovies.close();
    _genres.close();
    _search.close();
  }
}
