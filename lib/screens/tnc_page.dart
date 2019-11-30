import 'package:flutter/material.dart';

class TNCPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Terms & Conditions'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'PLEASE READ THESE TERMS OF USE CAREFULLY BEFORE USING THIS APP',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.0),
              Text(
                'By using this application on mobile phone, you signify that you have read, understand and agree to be bound by these Terms of Use and any other applicable law. Your continued use of the App shall be considered your acceptance to the revised Terms of Use. If you do not agree to these Terms of Use, please do not use this App.',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 12.0),
              Text(
                'To use the App, you may be asked to provide certain personal information (the “Personal Information”), including information about your weight, age and gender, to optimize your use of the App. If you choose to provide such Personal Information, you agree to provide accurate and current information about yourself, and DAILY WORKOUT will not be responsible for any injury related to any Personal Information you submit to the App or omit.',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
