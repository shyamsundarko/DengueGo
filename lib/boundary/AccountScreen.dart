import 'package:denguego/controller/ScreenManager.dart';
import 'package:denguego/controller/UserAccountManager.dart';
import 'package:denguego/shared/Constants.dart';
import 'package:flutter/material.dart';
import 'package:denguego/controller/AuthenticateManager.dart';

class AccountScreen extends StatefulWidget {
  static String id = 'Account';
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final AuthenticateManager _auth = AuthenticateManager();

  final _formKeyPassword = GlobalKey<FormState>();

  String email = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /*Image.asset(
                  'images/profile.png',
                ),*/
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
                  child: Center(
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: Column(
                          children: [
                            Icon(
                              Icons.account_circle,
                              size: 100,
                              color: Colors.grey[700],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                                child: Text(
                              'Hi, ${UserAccountManager.userDetails.name}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            )),
                            SizedBox(
                              height: 18,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.email,
                                      ),
                                    ),
                                    Text(
                                      "${UserAccountManager.userDetails.email}",
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.poll_rounded,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        UserAccountManager
                                                .userDetails.SurveyDone
                                            ? "Survey Risk Score: ${UserAccountManager.userDetails.SurveyScore}"
                                            : 'Survey not taken',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.warning_rounded,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        UserAccountManager
                                                .userDetails.SurveyDone
                                            ? "Risk Level: ${UserAccountManager.userDetails.RiskZone}"
                                            : 'Survey not taken',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 25,
                ),
                Text(
                  'Change password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Form(
                  key: _formKeyPassword,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Card(
                          child: TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Confirm Email ID'),
                            validator: (val) =>
                                val.isEmpty ? 'Enter valid Email' : null,
                            onChanged: (val) {
                              email = val;
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff5B92C8)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 12.0),
                              child: Text('Confirm',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15)),
                            ),
                            onPressed: () async {
                              if (_formKeyPassword.currentState.validate()) {
                                _auth.resetPassword(email);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 25,
                ),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffd05f5f),
                        padding: EdgeInsets.all(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.5),
                            child: Icon(Icons.logout),
                          ),
                          Text('Log Out',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ],
                      ),
                      onPressed: () async {
                        await _auth.signOut();
                        Navigator.popUntil(
                            context, ModalRoute.withName(ScreenManager.id));
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
