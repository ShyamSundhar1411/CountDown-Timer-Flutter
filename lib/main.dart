import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../widgets/countdown.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Countdown Timer',
        home: _MyHomePage(),
        theme: ThemeData(
          primaryColor: Colors.amberAccent,
          accentColor: Colors.deepOrangeAccent,
          appBarTheme: AppBarTheme(backgroundColor: Colors.transparent)
          
        ));
  }
}

class _MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(middle: Text("Timer"))
        : AppBar(title: Text("Timer"));
    return Container(
      decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.orange])),
      child:Scaffold(
      backgroundColor: Colors.transparent,
      appBar: appBar,
      body: CountDownWidget()
    ));
  }
}
