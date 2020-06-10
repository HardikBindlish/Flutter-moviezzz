import 'package:flutter/material.dart';
import 'package:moviezzz/src/Bloc/moviesprovider.dart';
import 'package:moviezzz/src/models/item_model.dart';
import 'package:moviezzz/src/screens/genre_list.dart';
import 'package:moviezzz/src/screens/info.dart';
import 'package:moviezzz/src/screens/recent_movies.dart';
import 'package:moviezzz/src/screens/top_rated_movies.dart';
import 'package:flutter_multi_carousel/carousel.dart';
import 'package:moviezzz/src/widgets/customNavbar.dart';

class HomePage extends StatefulWidget {
  createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  var type;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final bloc = MoviesProvider.of(context);
      bloc.allGenre();
    });
    super.initState();
    fetchMovies();
  }

  fetchMovies() {
    var data = {'type': 'M'};

    Future.delayed(Duration.zero, () async {
      final bloc = MoviesProvider.of(context);
      bloc.recentData(data);
    });

    Future.delayed(Duration.zero, () async {
      final bloc = MoviesProvider.of(context);
      bloc.topData(data);
    });
  }

  fetchSeasons() {
    var data = {'type': 'S'};

    Future.delayed(Duration.zero, () async {
      final bloc = MoviesProvider.of(context);
      bloc.recentData(data);
    });

    Future.delayed(Duration.zero, () async {
      final bloc = MoviesProvider.of(context);
      bloc.topData(data);
    });
  }

  Widget build(context) {
    final bloc = MoviesProvider.of(context);
    return Scaffold(
      body: Row(children: <Widget>[
        CustomNavbar(),
        Container(
          width: MediaQuery.of(context).size.width - 60,
          child: ListView(children: <Widget>[
            SizedBox(
              height: 10,
            ),
            _getHeadTabs(),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height -400,
                child: StreamBuilder(
                    stream: bloc.rMovies,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Movie>> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Carousel(
                        height: MediaQuery.of(context).size.height -400,
                        width: MediaQuery.of(context).size.width - 60,
                        type: Types.slideSwiper,
                        showIndicator: true,
                        initialPage: 0,
                        indicatorType: IndicatorTypes.bar,
                        onCarouselTap: (index) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Info(movie: snapshot.data[index])));
                        },
                        showArrow: false,
                        axis: Axis.horizontal,
                        children: List.generate(
                            snapshot.data.length,
                            (index) => Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            snapshot.data[index].image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )),
                      );
                    })),
            SizedBox(
              height: 80,
              child: StreamBuilder(
                  stream: bloc.genre,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Genre>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      height: 50,
                      width: MediaQuery.of(context).size.width - 60,
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GenreList(
                                          type: type, genre: index + 1)));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              color: Colors.red[900],
                              child: Text(
                                snapshot.data[index].genre,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                        padding: EdgeInsets.only(left: 10),
                        scrollDirection: Axis.horizontal,
                      ),
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Recent', style: TextStyle(fontWeight: FontWeight.w500)),
                  Icon(Icons.arrow_forward)
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: StreamBuilder(
                  stream: bloc.rMovies,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Movie>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container(
                      height: 190,
                      width: MediaQuery.of(context).size.width - 60,
                      child: ListView.builder(
                        padding: EdgeInsets.only(left: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Info(movie: snapshot.data[index])));
                            },
                            child: Container(
                              width: 120,
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data[index].image),
                                      fit: BoxFit.cover)),
                            ),
                          );
                        },
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Top Rated',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  Icon(Icons.arrow_forward)
                ],
              ),
            ),
            SizedBox(
                height: 200,
                child: StreamBuilder(
                    stream: bloc.tMovies,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Movie>> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container(
                        height: 190,
                        width: MediaQuery.of(context).size.width - 60,
                        child: ListView.builder(
                          padding: EdgeInsets.only(left: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Info(movie: snapshot.data[index])));
                              },
                              child: Container(
                                width: 120,
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            snapshot.data[index].image),
                                        fit: BoxFit.cover)),
                              ),
                            );
                          },
                        ),
                      );
                    })),
          ]),
        ),
      ]),
    );
  }

  _getHeadTabs() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  fetchMovies();
                  setState(() {
                    type = 'M';
                  });
                },
                child: Text('Films',
                    style: TextStyle(fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: GestureDetector(
            onTap: () {
              fetchSeasons();
              setState(() {
                type = 'S';
              });
            },
            child: Text(
              "Series",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
