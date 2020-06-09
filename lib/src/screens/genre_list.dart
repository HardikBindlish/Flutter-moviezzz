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

  fetching(genre) {
    var data = {'type': type,'genre':genre};

    Future.delayed(Duration.zero, () async {
      final bloc = MoviesProvider.of(context);
      bloc.recentData(data);
    });

    Future.delayed(Duration.zero, () async {
      final bloc = MoviesProvider.of(context);
      bloc.topData(data);
    });
  }
  
  Widget build(context){
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          children: <Widget>[
            CustomNavbar(),

            

          ],
        )
      )
    );
  }
}