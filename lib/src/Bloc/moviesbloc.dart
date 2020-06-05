import 'package:moviezzz/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:moviezzz/src/models/item_model.dart';

class MoviesBloc {
  Repository _repository = Repository();
  final _rmovies = BehaviorSubject<List<Movie>>();
  final _tmovies = BehaviorSubject<List<Movie>>();
  final _genres = BehaviorSubject<List<Genre>>();
  String title = '';

  Stream<List<Movie>> get rMovies => _rmovies.stream;

  Stream<List<Movie>> get tMovies => _tmovies.stream;


  Stream<List<Genre>> get genre => _genres.stream;

  recentMovie() async {
    List<Movie> rmovie = await _repository.fetchRMovies();
    _rmovies.sink.add(rmovie);
    title = 'Movie';
  }

  topMovie() async {
    List<Movie> tmovie = await _repository.fetchTMovies();
    _tmovies.sink.add(tmovie);
  }

  recentSeason() async {
    List<Movie> rseason = await _repository.fetchRSeasons();
    _rmovies.sink.add(rseason);
    title = 'Season';
  }

  topSeason() async {
    List<Movie> tseason = await _repository.fetchTSeasons();
    _tmovies.sink.add(tseason);
  }

  allGenre() async {
    List<Genre> tseason = await _repository.fetchGenres();
    _genres.sink.add(tseason);
  }

  dispose() {
    _rmovies.close();
    _tmovies.close();
    _genres.close();
  }
}
