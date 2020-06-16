import 'package:flutter/material.dart';
import 'package:moviezzz/src/Bloc/moviesprovider.dart';
import 'package:moviezzz/src/screens/home_page.dart';
import 'package:screen_loader/screen_loader.dart';
import 'moviesearch.dart';

class CustomNavbar extends StatefulWidget{
  createState(){
    return CustomNavbarState();
  }
}

class CustomNavbarState extends State<CustomNavbar> with ScreenLoader<CustomNavbar>{

  @override
  loader() {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      title: Center(
        child: CircularProgressIndicator()
      ),
    );
  }

  @override
  loadingBgBlur() => 10.0;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final bloc = MoviesProvider.of(context);
      bloc.searchdata();
    });
    super.initState();
  } 

  Widget screen(context){
    final bloc = MoviesProvider.of(context);

    return Container(
      width: 60,
      color: Colors.black,
      child: Column(
        children: <Widget>[

          Padding(

            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
            child: Image.asset('assets/movie.jpg', ),
          ),

           Expanded(
            child: Container(),
          ),

          InkWell(
            onTap: () async{
              // await this.performFuture(NetworkService.getData);
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => HomePage()
              ));
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              child: Icon(Icons.home, color: Colors.grey,),
            ),
          ),

          InkWell(
            onTap: (){
              showSearch(context: context, delegate: MovieSearch(bloc.sMovies));
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              child: Icon(Icons.search, color: Colors.grey,),
            ),
          ),

          InkWell(
            onTap: (){},
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              child: Icon(Icons.menu, color: Colors.grey,),
            ),
          ),

        ],
      ),
    );
  }
}

class NetworkService {
  static Future getData() async {
    return await Future.delayed(Duration(seconds: 2));
  }
}