import 'package:flutter/material.dart';
import 'package:moviezzz/src/Bloc/moviesprovider.dart';
import 'package:moviezzz/src/screens/recent_movies.dart';
import 'package:moviezzz/src/screens/top_rated_movies.dart';
import 'package:moviezzz/src/widgets/moviesearch.dart';
import 'package:moviezzz/src/widgets/sidebar.dart';

class HomeScreen extends StatefulWidget {
  createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final bloc = MoviesProvider.of(context);
      bloc.searchdata();
    });
    super.initState();
  } 

  Widget build(context) {
    final bloc = MoviesProvider.of(context);
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
          title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                Center(
                  child: Image.asset('assets/movie_appbar.png',
                        fit: BoxFit.cover,
                        height: 40,
                        width: 30,
                        alignment: FractionalOffset.center,
                      ),
               ),
              Text('MovieFy', style: TextStyle(color: Colors.red[900]))
            ],
          )),
          iconTheme: new IconThemeData(color: Colors.red[900]),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: Colors.red[900]),
              onPressed: () {
                showSearch(context: context, delegate: MovieSearch(bloc.sMovies,));
              },
            ),
          ],
      ),
      body: Center(
        child: ListView(
          children: [
            RecentMovies(),
            SizedBox(height: 17.0),
            TopRatedMovies()
          ],
        ),
      ),
    );
  }
}


