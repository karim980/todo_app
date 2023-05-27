import 'package:cource/todo_app/core/app_theme.dart';
import 'package:cource/todo_app/screen/home_screen.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ToDOHomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: appTheme,
    );
  }
}
