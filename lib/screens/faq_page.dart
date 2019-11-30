import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('FAQ'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'ARE THOSE THE WORKOUT MODULE ON HOMEPAGE?',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.0),
              Text(
                'In the homepage, we categorized all workouts based on the body parts so that users can easily find for the workout that is suitable for them.',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 12.0),
              Text(
                'HOW DO I USE THE CALCULATOR IN FITNETIC?',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.0),
              Text(
                'The calculator in FITNETIC helps user to calculate their bmi. Simply select your gender, height, weight and age.',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 12.0),
              Text(
                'CAN THE LOCATION SERVICE LOCATE GYMS?',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.0),
              Text(
                'Yes, FITNETIC location service provides user the famous gyms and users are able to search for location as well.',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 12.0),
              Text(
                'WHAT REWARDS CAN I REDEEM?',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.0),
              Text(
                'Go to FITNETIC\'s reward page. Here, you will be able to see what you can redeem based on your available coins that earn by using the app.',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 12.0),
              Text(
                'HOW DO I CHANGE MY PERSONAL INFORMATION?',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.0),
              Text(
                'After you log in to FITNETIC, go to profile page and you will see a "Edit Information". After you click on that, and you are able to change your information.',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
