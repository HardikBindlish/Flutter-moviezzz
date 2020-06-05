import 'package:flutter/material.dart';
import 'package:moviezzz/src/Bloc/moviesprovider.dart';
import 'package:moviezzz/src/models/item_model.dart';

class DropDownGenre extends StatefulWidget{
  createState(){
    return DropDownGenreState();
  }
}

class DropDownGenreState extends State<DropDownGenre>{
  void initState() {
    Future.delayed(Duration.zero, () async {
      final bloc = MoviesProvider.of(context);
      bloc.allGenre();
    });
    super.initState();
  }

  
  Widget build(context){
    final bloc = MoviesProvider.of(context);

    return StreamBuilder(
      stream: bloc.genre,
      builder: (BuildContext context, AsyncSnapshot<List<Genre>> snapshot){
        if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
        }
        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index){
              return Text(snapshot.data[index].genre);
          }
        );
      }
    );
  }
}