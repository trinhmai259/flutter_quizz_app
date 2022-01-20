import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/screens/quiz/quiz_screen.dart';
import 'package:flutter_quiz_app/screens/score/score_screen.dart';
import 'package:flutter_quiz_app/screens/welcom_screens.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: WelcomeScreen(),
    );
  }
}
