import 'package:flutter/material.dart';

class LegendScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AlertDialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 40,
        ),
        titlePadding: EdgeInsets.all(0),
        contentPadding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Container(
          decoration: BoxDecoration(
            color: Color(0xff5B92C8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          height: 60.00,
          width: double.infinity,
          child: Center(
            child: Text(
              'Legend',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Color(0xffdb2121),
                    size: 35,
                  ),
                  Icon(
                    Icons.arrow_forward_sharp,
                  ),
                  Expanded(
                    child: Text(
                      "High Risk area with 10 or more cases",
                      style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Color(0xfff38816),
                    size: 35,
                  ),
                  Icon(
                    Icons.arrow_forward_sharp,
                  ),
                  Expanded(
                    child: Text(
                      "High Risk area with less than 10 cases",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Color(0xff84cf2f),
                    size: 35,
                  ),
                  Icon(
                    Icons.arrow_forward_sharp,
                  ),
                  Expanded(
                    child: Text(
                      "No new cases, under surveillance for next 21 days",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Changes in appbar color indicates your Risk Level based on survey result.'
                  '\n'
                  'Default: red',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Montserrat',
                      fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Color(0xffcf7a79),
                    size: 30,
                  ),
                  Icon(
                    Icons.arrow_forward_sharp,
                  ),
                  Text(
                    "High Risk",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Color(0xffe2d182),
                    size: 30,
                  ),
                  Icon(
                    Icons.arrow_forward_sharp,
                  ),
                  Text(
                    "Medium Risk",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Color(0xffBCD49D),
                    size: 30,
                  ),
                  Icon(
                    Icons.arrow_forward_sharp,
                  ),
                  Text(
                    "Low Risk",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Noted',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Montserrat',
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
