import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  AnswerButton(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color(0xff5B92C8),
            padding: EdgeInsets.all(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              answerText,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          onPressed: selectHandler,
        ),
      ), //RaisedButton
    ); //Container
  }
}
