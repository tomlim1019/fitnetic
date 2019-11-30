import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fitnetic/components/Workout.dart';
import 'dart:convert';
import 'exercise_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  HomePage({@required this.userID});
  final String userID;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Workout> list = [];
  bool done = false;
  var rewards;
  var document;
  bool write=false;
  final date = DateTime.now();
  Firestore _fire = Firestore.instance;

  checkUser(){
    _fire.collection('user').where('uid', isEqualTo: widget.userID).snapshots().listen((data){
      for (var data in data.documents){
        rewards = data;
        document = data.documentID;
        write = true;
      }
      if(rewards == null && write == false){
        _fire.collection('user').add({
          'uid': widget.userID,
          'last_login': DateTime.now().toLocal().millisecondsSinceEpoch,
          'rewards': 10,
        });
      }
    }
    );
  }

  addReward() {
    if(date.difference(DateTime.fromMillisecondsSinceEpoch(rewards['last_login'])).inSeconds > 30){
      _fire.collection('user').document(document).updateData({
        'rewards': rewards['rewards']+5,
        'last_login': date.toLocal().millisecondsSinceEpoch,
      });
    }
    else print('nonono');
  }

  fetchPost() async {
    final response =
        await http.get('https://wger.de/api/v2/exercisecategory.json');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      for (int i = 0; i < 7; i++) {
        list.add(Workout.fromJson(json.decode(response.body), i));
      }
      setState(() {
        done = true;
      });
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    checkUser();
    fetchPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Workout',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        done
            ? Expanded(
                child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  childAspectRatio: 1.5,
                  crossAxisCount: 2,
                  children: List.generate(list.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        addReward();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExercisePage(
                                      workoutID: list[index].id,
                                      workout: list[index].musclePart,
                                    )));
                      },
                      child: Card(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                    child: Image.asset(
                                        'images/${list[index].musclePart.toLowerCase()}.png')),
                                Text(
                                  '${list[index].musclePart}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )),
                      ),
                    );
                  }),
                ),
              ))
            : Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
//      child: FutureBuilder<Post>(
//        future: fetchPost(),
//        builder: (context, snapshot) {
//          if (snapshot.hasData) {
//            print(snapshot.data.musclePart);
//            return Text(snapshot.data.musclePart);
//          } else if (snapshot.hasError) {
//            return Text("${snapshot.error}");
//          }
//
//          // By default, show a loading spinner.
//          return CircularProgressIndicator();
//        },
//      ),
      ],
    );
  }
}
