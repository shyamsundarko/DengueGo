import 'package:denguego/controller/SystemManager.dart';
import 'package:denguego/shared/Constants.dart';
import 'package:denguego/controller/UserAccountManager.dart';
import 'package:denguego/boundary/ResultScreen.dart';
import 'package:flutter/material.dart';
import 'package:denguego/boundary/QuestionScreen.dart';

class SurveyScreen extends StatefulWidget {
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  int _questionIndex = 0;
  int _totalScore = UserAccountManager.userDetails.SurveyScore;
  bool surveyCompleted = UserAccountManager.userDetails.SurveyDone;

  void resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      UserAccountManager.userDetails.SurveyDone = false;
      UserAccountManager.userDetails.SurveyScore = 0;
      UserAccountManager.userDetails.RiskZone = "High";
      UserAccountManager.userDetails.Reminders = [];
      surveyCompleted = false;
      SystemManager.userMgr.updateSurvey(UserAccountManager.userDetails.name);
      SystemManager.userMgr
          .updateReminders(UserAccountManager.userDetails.name);
    });
  }

  void answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          surveyCompleted
              ? ResultScreen(_totalScore, resetQuiz)
              : _questionIndex < questions.length
                  ? QuestionScreen(
                      answerQuestion: answerQuestion,
                      questionIndex: _questionIndex,
                      questions: questions,
                    )
                  : ResultScreen(_totalScore, resetQuiz), //Padding
        ],
      ),
    );
  }
}
