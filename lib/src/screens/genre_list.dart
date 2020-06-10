import 'package:flutter/material.dart';
import 'package:moviezzz/src/Bloc/moviesprovider.dart';
import 'package:moviezzz/src/models/item_model.dart';
import 'package:moviezzz/src/widgets/customNavbar.dart';

class GenreList extends StatefulWidget{
  createState(){
    return GenreListState();
  }
}

class GenreListState extends State<GenreList>{
  var type;

  // fetching(genre) {
  //   var data = {'type': type,'genre':genre};

  //   Future.delayed(Duration.zero, () async {
  //     final bloc = MoviesProvider.of(context);
  //     bloc.recentData(data);
  //   });

  //   Future.delayed(Duration.zero, () async {
  //     final bloc = MoviesProvider.of(context);
  //     bloc.topData(data);
  //   });
  // }
  
  Widget build(context){
    final bloc = MoviesProvider.of(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          children: <Widget>[
            CustomNavbar(),

            StreamBuilder(
              stream: bloc.rMovies,
              builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot1){
                if(!snapshot1.hasData){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return StreamBuilder(
                  stream: bloc.tMovies,
                  builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot2){
                    if(!snapshot1.hasData){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        // childAspectRatio: 2 / 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 8
                      ),
                      itemCount: 6,
                      itemBuilder: (context, int index){
                        if(type== 'M'){
                          return Column(
                          children: [

                          ],
                        );
                        }
                      },
                    );
                  },
                );
              },
            ),

          ],
        )
      )
    );
  }
}