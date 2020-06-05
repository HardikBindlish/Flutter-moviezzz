import 'package:flutter/material.dart';
import 'package:moviezzz/src/Bloc/moviesprovider.dart';
import 'package:moviezzz/src/models/item_model.dart';
import 'movies_detail.dart';

class RecentMovies extends StatefulWidget {
  @override
  _RecentMoviesState createState() => _RecentMoviesState();
}

class _RecentMoviesState extends State<RecentMovies> {
  void initState() {
//    Future.delayed(Duration.zero, () async {
//      final bloc = MoviesProvider.of(context);
//      bloc.recentMovie();
//    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = MoviesProvider.of(context);
    bloc.recentMovie();

    return StreamBuilder(
        stream: bloc.rMovies,
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(snapshot.hasError){
            return Center(
              child:Text(snapshot.error.toString())
          );
          }
          else{
            return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Recent Movies',
                                style: TextStyle(
                                    fontSize: 18.0, fontWeight: FontWeight.bold)),
                            FlatButton(onPressed: () {}, child: Text('View All')),
                          ],
                        ),
                      ),

                      SizedBox(
                          height: 200,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            height: 200,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: 130,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => MoviesDetail(movie: snapshot.data[index])
                                      ));
                                    },
                                    child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 160,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  snapshot.data[index].image),
                                              fit: BoxFit.cover),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 2.0,
                                              spreadRadius: 0.0,
                                              offset: Offset(2.0,
                                                  2.0), // shadow direction: bottom right
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        snapshot.data[index].title,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  ),
                                );
                              },
                            ),
                          )),                      
                    ],
                  ),
                );
          }
        }
    ); 
  }
}





