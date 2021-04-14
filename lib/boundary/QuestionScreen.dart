import 'package:denguego/widgets/Question.dart';
import 'package:flutter/material.dart';
import 'package:denguego/widgets/AnswerButton.dart';
import 'dart:ui' as ui;

class QuestionScreen extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;
  final Function surveyUpdate;

  QuestionScreen(
      {@required this.questions,
      @required this.answerQuestion,
      @required this.questionIndex,
      this.surveyUpdate});

  @override
  Widget build(BuildContext context) {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _width = logicalSize.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 30.0),
          height: 10.0,
          child: Row(
            children: List.generate(10, (int index) {
              return Container(
                decoration: BoxDecoration(
                  color:
                      index <= questionIndex ? Color(0xff5B92C8) : Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                ),
                height: 4.0,
                width: (_width - 32.0 - 15.0) / 10.0,
                margin: EdgeInsets.only(left: index == 0 ? 0.0 : 5.0),
              );
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 40, 8, 20),
          child: Text(
            'Question ${questionIndex + 1}',
            style: TextStyle(
              fontSize: 18,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Question(
            questions[questionIndex]['questionText'],
          ),
        ), //Question
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnswerButton(
                () => answerQuestion(answer['score']), answer['text']),
          );
        }).toList(),
      ],
    );
  }
}
