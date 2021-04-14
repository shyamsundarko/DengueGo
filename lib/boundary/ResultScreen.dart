import 'package:denguego/boundary/MainScreen.dart';
import 'package:denguego/boundary/NotificationScreen.dart';
import 'package:denguego/controller/ScreenManager.dart';
import 'package:denguego/controller/SystemManager.dart';
import 'package:denguego/shared/Constants.dart';
import 'package:flutter/material.dart';
import 'package:denguego/controller/UserAccountManager.dart';
import 'package:denguego/controller/LocalNotificationManager.dart';

class ResultScreen extends StatefulWidget {
  final int resultScore;
  final Function resetHandler;
  ResultScreen(this.resultScore, this.resetHandler);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    localNotificationManager.setOnNotificationClick(onNotificationClick);
  }

  void sendNotification() async {
    await localNotificationManager.showDailyAtTimeNotification();
    Navigator.pushNamed(context, ScreenManager.id);
    Navigator.pushNamed(context, MainScreen.id);
  }

  onNotificationClick(String payload) {
    Navigator.pushNamed(context, ScreenManager.id);
    Navigator.pushNamed(context, NotificationScreen.id);
  }

  String get resultPhrase {
    String resultText;
    if (widget.resultScore >= 70) {
      resultText = 'High';
    } else if (40 <= widget.resultScore && widget.resultScore < 70) {
      resultText = 'Medium';
    } else if (widget.resultScore <= 39) {
      resultText = 'Low';
    } else {
      resultText = 'Incorrect Score. Please try again!';
    }
    return resultText;
  }

  List<String> get values {
    List<String> reminderValues;
    if (resultPhrase.contains('High')) {
      reminderValues = highRiskValues;
    } else if (resultPhrase.contains('Medium')) {
      reminderValues = mediumRiskValues;
    } else if (resultPhrase.contains('Low')) {
      reminderValues = lowRiskValues;
    }
    return reminderValues;
  }

  @override
  Widget build(BuildContext context) {
    UserAccountManager.userDetails.RiskZone = resultPhrase;
    UserAccountManager.userDetails.SurveyDone = true;
    UserAccountManager.userDetails.SurveyScore = widget.resultScore;
    SystemManager.userMgr.updateSurvey(UserAccountManager.userDetails.name);

    UserAccountManager.userDetails.Reminders = values;
    SystemManager.userMgr.updateReminders(UserAccountManager.userDetails.name);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(child: Image.asset('images/thank-you.png')),
          Padding(
            padding: const EdgeInsets.fromLTRB(4.0, 40.0, 4.0, 4.0),
            child: Text(
              "Thank you for taking this survey!",
              style: TextStyle(
                fontSize: 22,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          //Text
          Text(
            'Risk Score: ${widget.resultScore} / 100',
            style: TextStyle(
              fontSize: 30,
              fontFamily: "Montserrat",
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
            child: Text(
              'You are at $resultPhrase risk!',
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: resultPhrase.contains('High')
                    ? Color(0xffd26666)
                    : resultPhrase.contains('Medium')
                        ? Color(0xffdec649)
                        : resultPhrase.contains('Low')
                            ? Color(0xff81aa4c)
                            : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff5B92C8),
                padding: EdgeInsets.all(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Restart Survey',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: widget.resetHandler,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff5B92C8),
                padding: EdgeInsets.all(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Enable daily reminders!',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () => sendNotification(),
            ),
          ),
        ], //<Widget>[]
      ), //Column
    ); //Center
  }
}
