import 'package:denguego/boundary/EmailVerificationScreen.dart';
import 'package:denguego/boundary/ForgotPasswordScreen.dart';
import 'package:denguego/boundary/LoginScreen.dart';
import 'package:denguego/boundary/NotificationScreen.dart';
import 'package:denguego/boundary/SignupScreen.dart';
import 'package:denguego/controller/AuthenticateManager.dart';
import 'package:denguego/controller/ScreenManager.dart';
import 'package:flutter/material.dart';
import 'package:denguego/boundary/MainScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:denguego/entity/UserAccount.dart';
import 'package:denguego/boundary/AccountScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserAccount>.value(
      value: AuthenticateManager().user,
      child: MaterialApp(
        title: 'Dengue Go',
        initialRoute: ScreenManager.id,
        routes: {
          ScreenManager.id: (context) => ScreenManager(),
          MainScreen.id: (context) => MainScreen(),
          ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          NotificationScreen.id: (context) => NotificationScreen(),
          // ReminderScreen.id: (context) => ReminderScreen(),
          AccountScreen.id: (context) => AccountScreen(),
          EmailVerification.id: (context) => EmailVerification(),
        },
      ),
    );
  }
}
