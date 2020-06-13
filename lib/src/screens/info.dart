import 'package:flutter/material.dart';
import 'package:moviezzz/src/models/item_model.dart';
import 'package:moviezzz/src/widgets/customNavbar.dart';
import 'package:url_launcher/url_launcher.dart'; 

class Info extends StatelessWidget{
  final Movie movie;

  Info({@required this.movie});

  Widget build(context){
    return Scaffold(
      body: Row(
        children: <Widget>[
          CustomNavbar(),
          Container(
            width: MediaQuery.of(context).size.width - 60,
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    movieHeader(),
                    SizedBox(
                      height: 5,
                    ),
                    moviesDescription(),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget movieHeader(){
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Container(
            height: 250,
            margin: EdgeInsets.only(bottom: 25),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(movie.image),
                fit: BoxFit.cover,
              ),
            )),
        CircleAvatar(
          backgroundColor: Colors.red.withOpacity(0.35),
          radius: 25,
          child: CircleAvatar(
            backgroundColor: Colors.red,
            child: Icon(Icons.play_arrow, size: 35, color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget moviesDescription(){
    return Column(
      children: <Widget>[
        Text(movie.title, style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),),
        SizedBox(height: 5.0,),
        Text(movie.releaseDate),
        SizedBox(height: 15.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              movie.releaseDate,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CircleAvatar(
                radius: 1.5,
                backgroundColor: Colors.black,
              ),
            ),
            Text(
              movie.type,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CircleAvatar(
                radius: 1.5,
                backgroundColor: Colors.black,
              ),
            ),
            Text(
              movie.downloadSize,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
         SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Icon(
                  Icons.favorite_border,
                  color: Colors.red[900],
                ),
                Text(movie.rating)
              ],
            ),
            Column(
              children: <Widget>[
                FlatButton(
                  onPressed: () async{
                    final url = movie.trailer;
                    if(await canLaunch(url)){
                      await launch(url);
                    }
                    else{
                      throw 'Could not lunch $url';
                    }
                  },
                  child: Icon(
                    Icons.youtube_searched_for,
                    color: Colors.red[900],
                  ),
                  // color: Colors.white,
                ),
                Text("Trailer")
              ],
            ),
            Column(
              children: <Widget>[
                FlatButton(
                  onPressed: () async{
                    final url = movie.download;
                    if(await canLaunch(url)){
                      await launch(url);
                    }
                    else{
                      throw 'Could not lunch $url';
                    }
                  },
                  child: Icon(
                    Icons.file_download,
                    color: Colors.red[900],
                 ),
                ),
                Text("Download")
              ],
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(movie.story),
        )
      ],
    );
  }

}
 