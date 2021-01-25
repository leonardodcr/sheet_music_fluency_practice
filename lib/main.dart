import 'package:flutter/material.dart';
import 'package:sheet_music_fluency_practice/pages/practice.dart';
import 'package:sheet_music_fluency_practice/pages/Home.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Home(),
    '/practice': (context) => Practice(),
  }
));

//https://pub.dev/packages/localstorage