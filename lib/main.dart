import 'package:flashchat/screens/chat.dart';
import 'package:flashchat/screens/login.dart';
import 'package:flashchat/screens/registration.dart';
import 'package:flashchat/screens/welcome.dart';
import 'package:flutter/material.dart';

void main() {
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
