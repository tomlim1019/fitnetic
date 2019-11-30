import 'package:flutter/material.dart';
import 'package:fitnetic/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'about_us_page.dart';
import 'faq_page.dart';
import 'tnc_page.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({this.userId, this.onSignedOut, this.auth});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseUser user;
  bool done = false;
  Firestore _fire = Firestore.instance;
  var name, document;
  String newName;

  getCurrentUser() async {
    user = await widget.auth.getCurrentUser();
    setState(() {
      done = true;
    });
    checkUser();
  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  checkUser(){
    try{
      _fire
          .collection('user')
          .where('uid', isEqualTo: user.uid)
          .snapshots()
          .listen((data) {
        for (var data in data.documents) {
          if (mounted){
            setState((){
              name = data['name'];
              document = data.documentID;
            });
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future playSound() async {
    final player = AudioCache();
    player.play('logout.wav');  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Expanded(
            child: done ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Account Information'),
                Text('ID: ${user.uid}'),
                Row(
                  children: <Widget>[
                    Text('Name: '),
                    name == null
                        ? Text('')
                        : Text(name),
                  ],
                ),
                Text('Email: ${user.email}'),
                FlatButton(
                  child: Text(
                    'Edit Information',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Center(child: Text('Edit Information')),
                            content: TextField(
                              autofocus: true,
                              decoration: InputDecoration(
                                labelText: 'Name',
                              ),
                              onChanged: (value){
                                newName=value;
                              },
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              FlatButton(
                                child: Text('OK'),
                                onPressed: () {
                                  _fire
                                      .collection('user')
                                      .document(document)
                                      .updateData({
                                    'name': newName,
                                  }).catchError((e) {
                                    print(e);
                                  });
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        });
                  },
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white)),
                ),
                FlatButton(
                  child: Text(
                    'About Us',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUsPage()));
                  },
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white)),
                ),
                FlatButton(
                  child: Text(
                    'FAQ',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQPage()));
                  },
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white)),
                ),
                FlatButton(
                  child: Text(
                    'Terms and Condition',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TNCPage()));
                  },
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white)),
                ),
                FlatButton(
                  child: Text(
                    'Log Out',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    playSound();
                    _signOut();
                  },
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white)),
                ),
              ],
            ) : SizedBox()
          ),
        ],
      ),
    );
  }
}
