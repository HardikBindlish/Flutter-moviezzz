import 'package:flutter/material.dart';
import 'package:moviezzz/src/Bloc/moviesprovider.dart';
import 'package:moviezzz/src/models/item_model.dart';
import 'info.dart';

class TopData extends StatefulWidget{
  createState(){
    return TopDataState();
  }
}

class TopDataState extends State<TopData>{
  Widget build(context){
    final bloc = MoviesProvider.of(context);
    return Column(
      children: [
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
      ],
    );
  }
}