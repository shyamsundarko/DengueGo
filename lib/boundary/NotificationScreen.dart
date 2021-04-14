import 'package:denguego/boundary/MainScreen.dart';
import 'package:denguego/controller/ScreenManager.dart';
import 'package:denguego/controller/UserAccountManager.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  static String id = 'NotificationScreen';
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<String> values = UserAccountManager.userDetails.Reminders;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xff5B92C8),
                UserAccountManager.userDetails.RiskZone == 'High'
                    ? Color(0xffcf7a79)
                    : UserAccountManager.userDetails.RiskZone == 'Medium'
                        ? Color(0xffe2d182)
                        : Color(0xffBCD49D),
              ],
            ),
          ),
        ),
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushNamed(context, ScreenManager.id);
              Navigator.pushNamed(context, MainScreen.id);
              //Navigator.pop(context);

            },
          ),
          Text(
            'Notifications',
            style: TextStyle(
              fontSize: 25.0,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 45,
          ),
        ]),
      ),
      body: (UserAccountManager.userDetails.SurveyDone)
          ? ListView(
              children: values.map((String key) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          key,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'No Notifications yet as survey have not been taken yet',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
    );
  }
}
