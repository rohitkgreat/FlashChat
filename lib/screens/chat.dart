import 'package:flutter/material.dart';
import 'package:mechat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

User logged;

class ChatScreen extends StatefulWidget {
  static String id2 = 'chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgcontrol = TextEditingController();
  String msg;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    getcurrent();
  }

  void getcurrent() async {
    try {
      final user = _auth.currentUser;
      if (user != null) logged = user;
      print(user.email);
    } catch (e) {
      print(e);
    }
  }

  void getmsg() async {
    await _firestore.collection('messages').snapshots().forEach((snapshot) {
      for (var msge in snapshot.docs) print(msge.data());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                getmsg();
                _auth.signOut();
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                List<Bubblemsg> messageWidgets = [];
                if (snapshot.hasData) {
                  final messages = snapshot.data.docs.reversed;

                  for (var message in messages) {
                    final messageData = message;
                    final messageText = messageData['text'];
                    final messageSender = messageData['sender'];

                    final currentuser = logged.email;

                    final messagebubble = Bubblemsg(
                      sender: messageSender,
                      text: messageText,
                      isme: currentuser == messageSender,
                    );
                    messageWidgets.add(messagebubble);
                  }
                }
                return Expanded(
                    child: ListView(
                  reverse: true,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  children: messageWidgets,
                ));
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: msgcontrol,
                      onChanged: (value) {
                        msg = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      msgcontrol.clear();
                      if (msg != "") {
                        _firestore.collection('messages').add({
                          'timestamp': FieldValue.serverTimestamp(),
                          'text': msg,
                          'sender': logged.email,
                        });
                        msg = "";
                      }

                      //Implement send functionality.
                    },
                    child: CircleAvatar(
                      radius: 20,
                      child: Icon(
                        Icons.send,
                        size: 30,

                        // style: kSendButtonTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Bubblemsg extends StatelessWidget {
  Bubblemsg({this.sender, this.text, this.isme});
  final String sender;
  final String text;
  bool isme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment:
            isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          Material(
            borderRadius: isme
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            elevation: 6,
            color: isme ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
