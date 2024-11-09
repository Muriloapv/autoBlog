// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/main_screen.dart'; // Certifique-se de ajustar o caminho para o arquivo criado

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Autoblog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
