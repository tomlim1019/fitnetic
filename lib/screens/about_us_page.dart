import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('About Us'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text('FITNETIC is a fitness mobile application that helps to spread awareness of fitness to the public and promote a healthy and balanced lifestyle to our users.', style: TextStyle(color: Colors.black),),
              SizedBox(height: 12.0),
              Text('We serve information on types of workout users can do in result to have a better understanding and make sure users do it the right way. Other than that, we also allow users to locate the nearest gyms near them as well as giving out rewards when they complete tasks.', style: TextStyle(color: Colors.black),),
            ],
          ),
        ),
      ),
    );
  }
}


