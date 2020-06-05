import 'package:flutter/material.dart';
import 'package:moviezzz/src/screens/recent_seasons.dart';
import 'package:moviezzz/src/screens/top_rated_seasons.dart';
import 'package:moviezzz/src/widgets/sidebar.dart';

class HomeScreenSeasons extends StatefulWidget {
  createState() {
    return HomeScreenSeasonsState();
  }
}

class HomeScreenSeasonsState extends State<HomeScreenSeasons> {
  Widget build(context){
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
          title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                Center(
                  child: Image.asset('assets/movie_appbar.png',
                        fit: BoxFit.cover,
                        height: 40,
                        width: 30,
                        alignment: FractionalOffset.center,
                      ),
               ),
              Text('MovieFy', style: TextStyle(color: Colors.red[900]))
            ],
          )),
          iconTheme: new IconThemeData(color: Colors.red[900]),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: Colors.red[900]),
              onPressed: () {},
            ),
          ],
      ),
      body: Center(
        child: ListView(
          children: [
            RecentSeasons(),
            SizedBox(height: 17.0),
            TopRatedSeasons()
          ],
        ),
      ),
    );
  }
}