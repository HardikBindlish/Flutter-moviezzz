import 'package:flutter/material.dart';
import 'package:moviezzz/src/screens/home_page.dart';
import 'package:moviezzz/src/screens/home_screen.dart';
import 'package:moviezzz/src/Bloc/moviesprovider.dart';

class App extends StatelessWidget{
  Widget build(context){
    return MoviesProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies Zone',
        home: HomePage(),
      ),
    ); 
  } 
}