import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fitnetic/services/authentication.dart';
import 'profile_page.dart';
import 'input_page.dart';
import 'location_page.dart';
import 'reward_page.dart';
import 'package:audioplayers/audio_cache.dart';

class NavigationScreen extends StatefulWidget {
  NavigationScreen({this.auth, this.onSignedOut, this.userId});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int selectedIndex = 0;
  var widgetOptions;
  var titleOptions;

  onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Future playSound() async {
    final player = AudioCache();
    player.play('login.wav');  }

  @override
  void initState() {
    playSound();
    widgetOptions=[
      HomePage(userID: widget.userId,),
      InputPage(),
      Location(),
      RewardPage(userID: widget.userId,),
      ProfilePage(auth: widget.auth, onSignedOut: widget.onSignedOut,)
    ];
    titleOptions=[
      'Home',
      'Calculator',
      'Location',
      'Rewards',
      'Profile'
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleOptions[selectedIndex]),
      ),
      body: Center(
        child: widgetOptions[selectedIndex],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 150),
        animationCurve: Curves.easeIn,
        height: 55.0,
        index: selectedIndex,
        backgroundColor: Color(0xFFff8a80),
        items: <Widget>[
          Icon(FontAwesomeIcons.home, size: 24),
          Icon(FontAwesomeIcons.calculator, size: 24),
          Icon(FontAwesomeIcons.locationArrow, size: 24),
          Icon(FontAwesomeIcons.gift, size: 24),
          Icon(FontAwesomeIcons.user, size: 24),
        ],
        onTap: (index) {
          onItemTapped(index);
        },
      ),
    );
  }
}
