import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/models/questions.dart';
import 'package:flutter_quiz_app/screens/score/score_screen.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

// We use get package for uor State management
class QuestionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //Lets animated our progess bar

  AnimationController? _animationController;
  Animation? _animation;
  // so that we can access uor animation outside
  Animation? get animation => _animation;

  PageController? _pageController;
  PageController? get pageController => this._pageController;

  List<Question> _questions = sample_data
      .map(
        (question) => Question(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index']),
      )
      .toList();

  List<Question> get questions => this._questions;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  int? _correctAns;
  int? get correctAns => this._correctAns;

  int? _selectedAns;
  int? get selectedAns => this._selectedAns;

  // for more about obs please check documentation
  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => this._numOfCorrectAns;
  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    // Our animation diration is 60s
    // so out plan is to fill the progress bar within 60s
    _animationController =
        AnimationController(duration: const Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!)
      ..addListener(() {
        // update like setState
        update();
      });

    // start our animation
    // Once 60s is completed go to the next qn
    _animationController?.forward().whenComplete((nextQuestion));

    _pageController = PageController();
    // TODO: implement onInit
    super.onInit();
  }

  // Called just before the Controller is deleted from memory
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _animationController!.dispose();
    _pageController!.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    //because once user press any option then it will run
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;
    // It will stop the counter
    _animationController?.stop();
    update();

    //Once user select an ans after 3s it will go to the next qn
    Future.delayed(Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController?.nextPage(
          duration: Duration(microseconds: 250), curve: Curves.ease);
      // Reset the couter
      _animationController?.reset();
      // Then start it again
      // Once timer us finish go to the next qn
      _animationController?.forward().whenComplete(nextQuestion);
    } else {
      // Get package provide us simple way to navigate another page
      Get.to(ScoreScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
