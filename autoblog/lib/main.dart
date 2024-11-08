import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(AutoblogApp());
}

class AutoblogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Autoblog',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
