import 'package:mechat/components/padding.dart';
import 'package:mechat/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mechat/screens/chat.dart';

class RegistrationScreen extends StatefulWidget {
  static String regs = 'registr';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email = " ";
  String pass = " ";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                  //Do something with the user input.
                },
                decoration:
                    fielddecoration.copyWith(hintText: 'Enter your email')
                // InputDecoration(
                //   hintText: 'Enter your email',
                //   contentPadding:
                //       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                //   border: OutlineInputBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(32.0)),
                //   ),
                //   enabledBorder: OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                //     borderRadius: BorderRadius.all(Radius.circular(32.0)),
                //   ),
                //   focusedBorder: OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                //     borderRadius: BorderRadius.all(Radius.circular(32.0)),
                //   ),
                // ),
                ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  pass = value;
                  //Do something with the user input.
                },
                decoration:
                    fielddecoration.copyWith(hintText: 'Enter your Password')
                // InputDecoration(
                //   hintText: 'Enter your password',
                //   contentPadding:
                //       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                //   border: OutlineInputBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(32.0)),
                //   ),
                //   enabledBorder: OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                //     borderRadius: BorderRadius.all(Radius.circular(32.0)),
                //   ),
                //   focusedBorder: OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                //     borderRadius: BorderRadius.all(Radius.circular(32.0)),
                //   ),
                // ),
                ),
            SizedBox(
              height: 24.0,
            ),

            Padd(
              color: Colors.blueAccent,
              text: 'Register',
              onpress: () async {
                try {
                  UserCredential newuser =
                      await _auth.createUserWithEmailAndPassword(
                          email: email, password: pass);
                  if (newuser != null)
                    Navigator.pushNamed(context, ChatScreen.id2);
                } catch (e) {
                  print('error');
                  print(e);
                }
              },
            )
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 16.0),
            //   child: Material(
            //     color: Colors.blueAccent,
            //     borderRadius: BorderRadius.all(Radius.circular(30.0)),
            //     elevation: 5.0,
            //     child: MaterialButton(
            //       onPressed: () {
            //         //Implement registration functionality.
            //       },
            //       minWidth: 200.0,
            //       height: 42.0,
            //       child: Text(
            //         'Register',
            //         style: TextStyle(color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
