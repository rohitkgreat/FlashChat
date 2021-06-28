import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mechat/screens/login.dart';
import 'package:mechat/screens/registration.dart';
import 'package:flutter/material.dart';
import 'package:mechat/constants.dart';
import 'package:mechat/components/padding.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:modal_progress_hud/modal_progress_hud.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  bool spin = false;
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.black87)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 60.0,
                    ),
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        'Flash Chat',
                        textStyle: colorizeTextStyle,
                        colors: colorizeColors,
                      ),
                    ],
                    isRepeatingAnimation: true,
                    repeatForever: true,
                  ),
                  // Text(
                  //   'Flash Chat',
                  //   style: TextStyle(
                  //     fontSize: 45.0,
                  //     fontWeight: FontWeight.w900,
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              Padd(
                  color: Colors.lightBlueAccent,
                  text: 'Log In',
                  onpress: () {
                    setState(() {
                      spin = true;
                    });

                    Navigator.pushNamed(context, LoginScreen.login);
                    setState(() {
                      spin = false;
                    });
                  }),
              Padd(
                color: Colors.blueAccent,
                text: 'Register',
                onpress: () {
                  Navigator.pushNamed(context, RegistrationScreen.regs);
                },
              )
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: 16.0),
              //   child: Material(
              //     color: Colors.blueAccent,
              //     borderRadius: BorderRadius.circular(30.0),
              //     elevation: 5.0,
              //     child: MaterialButton(
              //       onPressed: () {
              //         //Go to registration screen.
              //         Navigator.pushNamed(context, RegistrationScreen.regs);
              //       },
              //       minWidth: 200.0,
              //       height: 42.0,
              //       child: Text(
              //         'Register',
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
