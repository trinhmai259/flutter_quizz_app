import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/controllers/question_controller.dart';
import 'package:flutter_quiz_app/screens/quiz/components/body.dart';
import 'package:get/instance_manager.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //Flutter show the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _controller.nextQuestion,
            child: Text("Skip"),
            style: TextButton.styleFrom(primary: Colors.white),
          )
        ],
      ),
      body: Body(),
    );
  }
}
