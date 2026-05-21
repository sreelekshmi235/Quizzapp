import 'package:flutter/material.dart';
import 'package:quizzapp/quizz%20app/quizstart.dart';






void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,
      home:QuizStartPage()
    );
  }
}