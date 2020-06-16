import 'package:moviezzz/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:moviezzz/src/models/item_model.dart';

class MoviesBloc {
  Repository _repository = Repository();
  final _rmovies = BehaviorSubject<List<Movie>>();
  final _tmovies = BehaviorSubject<List<Movie>>();
  final _genres = BehaviorSubject<List<Genre>>();
  final _search = BehaviorSubject<List<Movie>>();
  final _rGenre = BehaviorSubject<List<Movie>>();
  final _tGenre = BehaviorSubject<List<Movie>>();
  final _detail = BehaviorSubject<Movie>();
  final _similar = BehaviorSubject<List<Movie>>();

  Stream<List<Movie>> get rMovies => _rmovies.stream;

  Stream<List<Movie>> get tMovies => _tmovies.stream;

  Stream<List<Genre>> get genre => _genres.stream;

  Stream<List<Movie>> get sMovies => _search.stream;

  Stream<List<Movie>> get rGenre => _rGenre.stream;

  Stream<List<Movie>> get tGenre => _tGenre.stream;

  Stream<Movie> get details => _detail.stream;

  Stream<List<Movie>> get similar => _similar.stream;


  movieDetail(id)async {
    Movie details = await _repository.detail(id);
    _detail.sink.add(details);
  }

  movieSimilar(id)async {
    List<Movie> similars = await _repository.similar(id);
    _similar.sink.add(similars);
  }

  recentData(data) async {
    List<Movie> rmovie = await _repository.fetchRData(data);
    _rmovies.sink.add(rmovie);
  }

  topData(data) async {
    List<Movie> tmovie = await _repository.fetchTData(data);
    _tmovies.sink.add(tmovie);
  }

  recentGenreData(data) async {
    List<Movie> rmovie = await _repository.fetchGenreRData(data);
    _rGenre.sink.add(rmovie);
  }

  topGenreData(data) async {
    List<Movie> tmovie = await _repository.fetchGenreTData(data);
    _tGenre.sink.add(tmovie);
  }

  allGenre() async {
    List<Genre> allgenre = await _repository.fetchGenres();
    _genres.sink.add(allgenre);
  }

  searchdata() async {
    List<Movie> smovie = await _repository.search();
    _search.sink.add(smovie);
  }

  dispose() {
    _rmovies.close();
    _tmovies.close();
    _genres.close();
    _rGenre.close();
    _tGenre.close();
    _search.close();
    _detail.close();
    _similar.close();
  }
}
