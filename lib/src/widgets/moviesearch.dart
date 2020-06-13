import 'package:flutter/material.dart';
import 'package:moviezzz/src/models/item_model.dart';
import 'package:moviezzz/src/screens/info.dart';

class MovieSearch extends SearchDelegate {
  final Stream<List<Movie>> movieList;
  
  MovieSearch(this.movieList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear, color: Colors.red[900],),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.red[900],),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<List<Movie>>(
      stream: movieList,
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('No results found!'),
          );
        }
        final results =snapshot.data.where((a) => a.title.toLowerCase().contains(query));

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (BuildContext context, int index){
            return Column(
              children: results.map<Card>((a) => Card(
                  elevation: 5.0,
                  child: GestureDetector(
                    onTap: (){
                      if(results != null){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Info(movie: a)
                        ),
                       );
                      }
                    },
                    child: Row(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(a.image))),
                      ),

                      Container(
                        height: 100,
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(a.title,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                  width: 200,
                                  child: Text(
                                    a.story,
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87),
                                  )),
                            
                            ]),
                      ),
                    ],
                  ),
                  )
                )
                )
              .toList(),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<List<Movie>>(
      stream: movieList,
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('No results found!'),
          );
        }
        final results =
            snapshot.data.where((a) => a.title.toLowerCase().contains(query));
        return ListView(
          children: results
              .map<Card>((a) => Card(
                  elevation: 5.0,
                  child: GestureDetector(
                    onTap: (){
                      close(context,a);
                    },
                    child: Row(
                    children: <Widget>[
                      Container(
                        height:80,
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(a.title,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold, color: Colors.blue)),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                  width: 200,
                                  child: Text(
                                    a.releaseDate,
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87),
                                  )),
                              // SizedBox(
                              //   height: 10.0,
                              // ),
                              // Container(
                              //     width: 200,
                              //     child: Text(
                              //       a.rating,
                              //       style: TextStyle(
                              //           fontSize: 14.0, color: Colors.black87),
                              //     )),
                            ]),
                      ),
                    ],
                  ),
                  )
                )
                )
              .toList(),
        );
      },
    );
  }
}
