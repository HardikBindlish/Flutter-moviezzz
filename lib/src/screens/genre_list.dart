
import 'package:flutter/material.dart';
import 'package:moviezzz/src/Bloc/moviesprovider.dart';
import 'package:moviezzz/src/models/item_model.dart';
import 'package:moviezzz/src/widgets/customNavbar.dart';
import 'package:screen_loader/screen_loader.dart';

import 'info.dart';

class GenreList extends StatefulWidget {
  final String type;
  final int genre;

  const GenreList({Key key, this.type, this.genre}) : super(key: key);
  createState() {
    return GenreListState(type,genre);
  }
}

class GenreListState extends State<GenreList> with ScreenLoader<GenreList>{
//  var type;
  final String type;
  final int genre;

  GenreListState(this.type, this.genre);

  @override
  void initState() {
    super.initState();
    fetching();
  }

   fetching() {
     var data = {'type': type,'genre':genre};

     Future.delayed(Duration.zero, () async {
       final bloc = MoviesProvider.of(context);
       bloc.recentGenreData(data);
     });

     Future.delayed(Duration.zero, () async {
       final bloc = MoviesProvider.of(context);
       bloc.topGenreData(data);
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
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Recent',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: StreamBuilder(
                  stream: bloc.rGenre,
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
                            onTap: () async{
                              await this.performFuture(NetworkService.getData);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Info(
                                          id: snapshot.data[index].id)));
                            },
                            child: Container(
                              width: 120,
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data[index].image),
                                      fit: BoxFit.cover)
                                      ),
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
                ],
              ),
            ),
            SizedBox(
                height: 200,
                child: StreamBuilder(
                    stream: bloc.tGenre,
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
                              onTap: () async{
                                await this.performFuture(NetworkService.getData);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Info(
                                            id: snapshot.data[index].id)));
                              },
                              child: Container(
                                width: 120,
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(snapshot.data[index].image),
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
}

class NetworkService {
  static Future getData() async {
    return await Future.delayed(Duration(seconds: 3));
  }
}


