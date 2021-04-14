import 'package:denguego/boundary/LoginScreen.dart';
import 'package:denguego/boundary/MainScreen.dart';
import 'package:denguego/controller/AuthenticateManager.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static String id = 'SignUpScreen';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthenticateManager _auth = AuthenticateManager();
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  String password = ' ';
  String name = ' ';
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff5B92C8),
              Color(0xffBCD49D),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 35.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: SizedBox(
                            height: 200,
                            child: Image.asset(
                              'images/signUp.png',
                            ),
                          ),
                        ),
                        Text(
                          'Welcome to DengueGo!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 8, 12, 4),
                          child: Text(
                            ' Let\'s all help in keeping our city safe!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.person),
                              labelText: 'Name',
                            ),
                            validator: (val) =>
                                val.isEmpty ? 'Enter your name' : null,
                            onChanged: (val) {
                              setState(() => name = val);
                            }),
                        SizedBox(height: 20.0),
                        TextFormField(
                          initialValue: email,
                          decoration: InputDecoration(
                            enabled: false,
                            icon: Icon(Icons.email_sharp),
                            labelText: 'Email',
                          ),
                          //readOnly: true,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.vpn_key),
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey[800]),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                            validator: (val) => val.isNotEmpty
                                ? val.length < 6
                                    ? 'Enter a password with 6+ characters'
                                    : null
                                : 'Enter password',
                            obscureText: _obscureText,
                            onChanged: (val) {
                              setState(() => password = val);
                            }),
                        SizedBox(height: 30.0),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff5B92C8)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(50.0, 10, 50, 10),
                              child: Text('Register',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold)),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => showSpinner = true);
                                await _auth.registerNewUser(
                                    email, password, name);
                                Navigator.pushNamed(context, MainScreen.id);
                              }
                              setState(() => showSpinner = false);
                            }),
                        TextButton(
                          child: Text(
                            "Have an account? Login Here",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                        ),
                      ],
                    )),
              ),
            ),
            showSpinner
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : SizedBox(),
          ]),
        ),
      ),
    );
  }
}
