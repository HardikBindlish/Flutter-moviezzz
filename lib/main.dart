import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviezzz/src/app.dart';

void main() {
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black,
  ));
 return runApp(App());
}
