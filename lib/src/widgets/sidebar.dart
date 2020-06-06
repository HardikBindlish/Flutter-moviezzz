import 'package:flutter/material.dart';
import 'package:moviezzz/src/Bloc/moviesprovider.dart';
import 'package:moviezzz/src/models/item_model.dart';


class NavDrawer extends StatefulWidget {
  createState() {
    return NavDrawerState();
  }
}

class NavDrawerState extends State<NavDrawer> {
  ScrollController _scrollController;
  int genre;

  onListExpansionChanged(bool expanded) {
    //returns if it was expanded (true) or collapsed (false)
    if (expanded) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final bloc = MoviesProvider.of(context);
      bloc.allGenre();
      _scrollController = ScrollController();
    });
    super.initState();
  }

  fetchMovies() {
    var data = {'type':'M','genre':genre};

    Future.delayed(Duration.zero, () async {
      final bloc = MoviesProvider.of(context);
      bloc.recentMovie(data);
    });

    Future.delayed(Duration.zero, () async {
      final bloc = MoviesProvider.of(context);
      bloc.topMovie();
    });
  }

  fetchSeasons() {
    Future.delayed(Duration.zero, () async {
      final bloc = MoviesProvider.of(context);
      bloc.recentSeason();
    });

    Future.delayed(Duration.zero, () async {
      final bloc = MoviesProvider.of(context);
      bloc.topSeason();
    });
  }

  Widget build(context) {
    final bloc = MoviesProvider.of(context);

    return Drawer(
      child: ListView(children: <Widget>[
        DrawerHeader(
          child: Text('Side Menu',
              style: TextStyle(fontSize: 25.0, color: Colors.black)),
          decoration: BoxDecoration(
            color: Colors.green,
            image: DecorationImage(
                image: AssetImage('assets/sidebar_pic.png'), fit: BoxFit.fill),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))),
          child: InkWell(
              onTap: () {
                fetchMovies();
//                Navigator.push(context, MaterialPageRoute(
//                  builder: (context) => HomeScreen()
//                ));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Movies',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          )
                        ],
                      ),
                      Icon(Icons.movie)
                    ]),
              )),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))),
          child: InkWell(
              onTap: () {
                fetchSeasons();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Seasons',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          )
                        ],
                      ),
                      Icon(Icons.movie_filter)
                    ]),
              )),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[400]))),
          child: StreamBuilder(
              stream: bloc.genre,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Genre>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ExpansionTile(
                  title: Text(
                    'Genre',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  children: <Widget>[
                    ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                genre = index + 1;
                              });
                              fetchMovies();
                            },
                            child: Card(
                              child: Container(
                                height: 30,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text(snapshot.data[index].genre),
                              ),
                            ),
                          );
                        })
                  ],
                );
              }),
        ),
      ]),
    );
  }
}
