import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sheet_music_fluency_practice/pages/practice.dart';
import 'package:sheet_music_fluency_practice/pages/Home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((value) => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/practice': (context) => Practice(),
      }
  )));
}