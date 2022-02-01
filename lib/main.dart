import 'package:blinkedid/registroPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistroPage(),
      color: Color(0xffffffff),
      theme: ThemeData(primaryColor: Color(0xff07070)),
    );
  }
}
