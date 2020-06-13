import 'package:flutter/material.dart';
import 'package:moviezzz/src/screens/home_page.dart';
import 'package:moviezzz/src/Bloc/moviesprovider.dart';
import 'package:screen_loader/screen_loader.dart';

class App extends StatelessWidget{
  Widget build(context){
    return MoviesProvider(
      child: ScreenLoaderApp(
        app: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movies Zone',
          home: HomePage(),
        ),
        globalLoader: AlertDialog(
        title: Text('Gobal Loader..'),
        ),
        globalLoadingBgBlur: 20.0,
      )
    ); 
  } 
}