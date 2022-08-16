import 'package:flutter/material.dart';
import 'package:tic_tac_toe_project/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF00061a),
        shadowColor: Color(0xFF001456),
        splashColor: Color(0xFF4169e8),
      ),
      home: HomePage(),
    );
  }
}