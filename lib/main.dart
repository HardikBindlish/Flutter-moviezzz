import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviezzz/src/mainScreen.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black,
  ));
 return runApp(
   MaterialApp(
     home: App()
   )
 );
}

class App extends StatefulWidget{
  createState(){
    return AppState();
  }
}

class AppState extends State<App>{
  Widget build(context){
    return SplashScreen(
      seconds: 7,
      backgroundColor: Colors.black,
      image: Image.asset('assets/loading.jpg'),
      loaderColor: Colors.white,
      photoSize: 150,
      navigateAfterSeconds: MainScreen(),
    );
  }
}
