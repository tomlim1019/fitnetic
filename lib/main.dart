import 'package:flutter/material.dart';
import 'package:fitnetic/screens/root_page.dart';
import 'services/authentication.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFFb83939),
        scaffoldBackgroundColor: Color(0xFFf06a63),
        textTheme: TextTheme(body1:TextStyle(color: Colors.white)),
        hintColor: Colors.white,
        buttonColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Color(0xFF820013)
        )
      ),
      home: RootPage(auth: Auth(),),
    );
  }
}