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
        title: 'Stop Watch',
        home: _MyHomePage(),
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.pinkAccent,
          scaffoldBackgroundColor: Colors.black,
        ));
  }
}

class _MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(middle: Text("Stop Watch"))
        : AppBar(title: Text("Stop Watch"));
    return Scaffold(
      appBar: appBar,
      body: CountDownWidget()
    );
  }
}
