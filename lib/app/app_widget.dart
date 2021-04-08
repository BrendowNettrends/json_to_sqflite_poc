import 'package:flutter/material.dart';
import 'package:json_to_sqflite_poc/app/views/home_view.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Json to SQFLite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: HomeView(),
    );
  }
}
