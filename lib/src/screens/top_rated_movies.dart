import 'package:flutter/material.dart';
import 'package:moviezzz/src/Bloc/moviesprovider.dart';
import 'package:moviezzz/src/models/item_model.dart';
import 'movies_detail.dart';

class TopRatedMovies extends StatefulWidget {
  @override
  _TopMoviesState createState() => _TopMoviesState();
}

class _TopMoviesState extends State<TopRatedMovies> {
  var data = {'type': 'M'};
  
  Widget build(BuildContext context) {
    final bloc = MoviesProvider.of(context);
    bloc.topData(data);

    return StreamBuilder(
        stream: bloc.tMovies,
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
              child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          // childAspectRatio: 2 / 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 8
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, int index){
                          return Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              image: DecorationImage(
                                image: NetworkImage(snapshot.data[index].image),
                                fit: BoxFit.cover
                              ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                 offset: Offset(2.0,2.0), // shadow direction: bottom right
                              )
                            ],
                          ),
                          );
                      },
                    ),
          );
          }
        });
  }
}

// Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 SizedBox(height: 17.0),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Text('Top-Rated ${snapshot.data[0].type}',
//                           style: TextStyle(
//                               fontSize: 18.0, fontWeight: FontWeight.bold)),
//                       FlatButton(onPressed: () {}, child: Text('View All')),
//                     ],
//                   ),
//                 ),
//                 Flexible(
//                     fit: FlexFit.loose,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                       // height: 500,
//                       child: ListView.builder(
//                         scrollDirection: Axis.vertical,
//                         itemCount: snapshot.data.length,
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemBuilder: (BuildContext context, int index) {
//                           return Container(
//                             child: GestureDetector(
//                                onTap: (){
//                                 Navigator.push(context, MaterialPageRoute(
//                                   builder: (context) => MoviesDetail(movie: snapshot.data[index])
//                                 ));
//                               },
//                               child: Column(
//                               children: <Widget>[
//                                 Card(
//                                   elevation: 5,
//                                   child: Row(children: <Widget>[
//                                     Container(
//                                         height: 150,
//                                         width: 100,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.only(
//                                               topLeft: Radius.circular(5.0),
//                                               bottomLeft: Radius.circular(5.0)),
//                                           image: DecorationImage(
//                                               image: NetworkImage(
//                                                   snapshot.data[index].image),
//                                               fit: BoxFit.cover),
//                                         )),
//                                     Container(
//                                       height: 150,
//                                       padding: const EdgeInsets.all(10.0),
//                                       child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: <Widget>[
//                                             Text(snapshot.data[index].title,
//                                                 style: TextStyle(
//                                                     fontSize: 16.0,
//                                                     fontWeight:
//                                                         FontWeight.bold)),
//                                             SizedBox(
//                                               height: 10.0,
//                                             ),
//                                             Container(
//                                                 width: 240,
//                                                 child: Text(
//                                                   snapshot.data[index].story,
//                                                   style: TextStyle(
//                                                       fontSize: 14.0,
//                                                       color: Colors.black87),
//                                                 )),
//                                           ]),
//                                     ),
//                                   ]),
//                                 ),
//                               ],
//                             ),
//                             ),
//                           );
//                         },
//                       ),
//                     )),
//               ],
//             ),
