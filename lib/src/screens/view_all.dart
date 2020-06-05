import 'package:flutter/material.dart';

class ViewAll extends StatefulWidget{
  createState(){
    return ViewAllState();
  }
}

class ViewAllState extends State<ViewAll>{
  Widget build(context){
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfff4f4f4),
        iconTheme: IconThemeData(
          color: Colors.red[900], 
        ),
      ),
      body: null,
    );
  }
}