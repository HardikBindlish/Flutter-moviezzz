import 'package:flutter/material.dart';
import 'package:moviezzz/src/Bloc/moviesprovider.dart';
import 'package:moviezzz/src/models/item_model.dart';
import 'package:moviezzz/src/screens/genre_list.dart';
import 'package:moviezzz/src/screens/info.dart';
import 'package:flutter_multi_carousel/carousel.dart';
import 'package:moviezzz/src/screens/recentData.dart';
import 'package:moviezzz/src/screens/topData.dart';
import 'package:moviezzz/src/widgets/customNavbar.dart';
import 'package:screen_loader/screen_loader.dart';

class HomePage extends StatefulWidget {
  createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with ScreenLoader<HomePage>{
  var type;
  Color _color1 = Colors.red[900];
  Color _color2 = Colors.grey;

  @override
  loader() {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      title: Center(
        child: CircularProgressIndicator()
      ),
    );
  }

  @override
  loadingBgBlur() => 10.0;

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
    var data = {'type': 'Movie'};

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
    var data = {'type': 'Season'};

    Future.delayed(Duration.zero, () async {
      final bloc = MoviesProvider.of(context);
      bloc.recentData(data);
    });

    Future.delayed(Duration.zero, () async {
      final bloc = MoviesProvider.of(context);
      bloc.topData(data);
    });
  }

  Widget screen(context) {
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
                        showIndicator: false,
                        initialPage: 0,
                        indicatorBackgroundColor: Colors.transparent,
                        indicatorType: IndicatorTypes.bar,
                        onCarouselTap: (index) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Info(id: snapshot.data[index].id)));
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
                            onTap: () async {
                              await this.performFuture(NetworkService.getData);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GenreList(
                                          type: type, genre: snapshot.data[index].id)));
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
            RecentData(),
            SizedBox(
              height: 30,
            ),
            TopData(),
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
                onTap: () async{
                  await this.performFuture(NetworkService.getData);
                  fetchMovies();
                  setState(() {
                    type = 'Movie';
                    _color1 = new Color(0xFFB71C1C);
                    _color2 = new Color(0xFF9E9E9E);
                  });
                },
                child: Text('Films',
                    style: TextStyle(fontWeight: FontWeight.w500, color: _color1)),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: GestureDetector(
            onTap: () async{
              await this.performFuture(NetworkService.getData);
              fetchSeasons();
              setState(() {
                type = 'Season';
                _color2 = new Color(0xFFB71C1C);
                _color1 = new Color(0xFF9E9E9E);
              });
            },
            child: Text(
              "Series",
              style: TextStyle(fontWeight: FontWeight.w500, color: _color2),
            ),
          ),
        ),
      ],
    );
  }
}

class NetworkService {
  static Future getData() async {
    return await Future.delayed(Duration(seconds: 2));
  }
}
