import 'package:flutter/material.dart';
import 'package:pld_app/event_list_screen.dart';
//Amín Jesús Báez Espinosa 2021-0929

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PLD App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: EventListScreen(),
    );
  }
}
