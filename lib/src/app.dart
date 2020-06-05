import 'package:flutter/material.dart';
import 'package:moviezzz/src/screens/home_screen.dart';
import 'package:moviezzz/src/Bloc/moviesprovider.dart';

class App extends StatelessWidget{
  Widget build(context){
    return MoviesProvider(
      child: MaterialApp(
        title: 'Movies Zone',
        home: HomeScreen(),
      ),
    ); 
  } 
}