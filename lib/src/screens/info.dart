import 'package:flutter/material.dart';
import 'package:moviezzz/src/Bloc/moviesprovider.dart';
import 'package:moviezzz/src/models/item_model.dart';
import 'package:moviezzz/src/widgets/customNavbar.dart';
import 'package:url_launcher/url_launcher.dart'; 

class Info extends StatefulWidget{
  final int id;

  const Info({Key key, this.id}) : super(key: key);
  createState(){
    return InfoState(id);
  }
}

class InfoState extends State<Info>{
  final int id;

  InfoState(this.id);

  @override
  void initState() {
    super.initState();
    detailing();
  }

   detailing() {
    int i = id;
    Future.delayed(Duration.zero, () async {
       final bloc = MoviesProvider.of(context);
       bloc.movieDetail(i);
     });

     Future.delayed(Duration.zero, () async {
       final bloc = MoviesProvider.of(context);
       bloc.movieSimilar(i);
     });
   }

  Widget build(context){
    final bloc = MoviesProvider.of(context);
    return Scaffold(
      body: StreamBuilder(
        stream: bloc.details,
        builder: (BuildContext context, AsyncSnapshot<Movie> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Row(
            children: <Widget>[
              CustomNavbar(),
              Container(
                width: MediaQuery.of(context).size.width - 60,
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Stack(
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
                                    image: NetworkImage(snapshot.data.image),
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
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        Column(
                          children: <Widget>[
                            Text(snapshot.data.title, style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),),
                            SizedBox(height: 5.0,),
                            Text(snapshot.data.genre[0].genre),
                            SizedBox(height: 15.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  snapshot.data.releaseDate,
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
                                  snapshot.data.rating,
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
                                  snapshot.data.type,
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
                                    FlatButton(
                                      onPressed: null, 
                                      child: Icon(
                                        Icons.favorite_border,
                                        color: Colors.red[900],
                                      ),
                                    ),
                                    Text(snapshot.data.rating)
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                      onPressed: () async{
                                        final url = snapshot.data.trailer;
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
                                      // onPressed: null,
                                      onPressed: () async{
                                        final url = snapshot.data.episode[id].download;
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
                              child: Text(snapshot.data.story),
                            ),
                            SizedBox(height: 10,),
                            SizedBox(
                              height: 100,
                              child: NotificationListener<OverscrollIndicatorNotification>(
                                onNotification: (OverscrollIndicatorNotification overscroll) {
                                  overscroll.disallowGlow();
                                  return false;
                              },
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data.episode.length,
                                itemBuilder: (BuildContext context, int index){
                                  return Container( 
                                    child: Column(
                                      children: [
                                        Card(
                                          elevation: 5.0,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                                            height: 40,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  onTap: () async{
                                                    final url = snapshot.data.episode[index].download;
                                                    if(await canLaunch(url)){
                                                      await launch(url);
                                                    }
                                                    else{
                                                      throw 'Could not lunch $url';
                                                    }
                                                  },
                                                  child: Text('Download', style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.w600),),
                                                ),
                                                Text(snapshot.data.episode[index].quality),
                                                Text(snapshot.data.episode[index].title, style: TextStyle(fontWeight: FontWeight.bold),),
                                                Text(snapshot.data.episode[index].downloadSize)
                                                ]
                                              ),
                                            )
                                          ),
                                        ],
                                      ),
                                  );
                                }
                              ),
                              ) 
                            ),
                            SizedBox(height: 5.0,),
                            StreamBuilder(
                              stream: bloc.similar,
                              builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot){
                                if(!snapshot.hasData){
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "More like this".toUpperCase(),
                                            style: TextStyle(fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 2,
                                              color: Colors.red,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      height: 500,
                                      child: GridView.builder(
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              childAspectRatio: 2 / 3,
                                              crossAxisSpacing: 3,
                                              mainAxisSpacing: 5),
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: (){
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Info(id: snapshot.data[index].id)));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(image: NetworkImage(snapshot.data[index].image),
                                                    fit: BoxFit.cover)
                                                ),
                                              ),
                                            );
                                          }),
                                    )
                                  ],
                                );
                              },
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
 