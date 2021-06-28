import 'package:firebase_core/firebase_core.dart';
import 'package:mechat/screens/chat.dart';
import 'package:mechat/screens/login.dart';
import 'package:mechat/screens/registration.dart';
import 'package:mechat/screens/welcome.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home: WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ChatScreen.id2: (context) => ChatScreen(),
        LoginScreen.login: (context) => LoginScreen(),
        RegistrationScreen.regs: (context) => RegistrationScreen(),
      },
    );
  }
}
