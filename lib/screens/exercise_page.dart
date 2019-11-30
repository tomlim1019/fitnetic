import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fitnetic/components/Exercises.dart';
import 'dart:convert';
import 'exercise_details_page.dart';

class ExercisePage extends StatefulWidget {
  ExercisePage({@required this.workoutID, @required this.workout});
  static String title = 'NewsFeed';
  final int workoutID;
  final String workout;
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  List<Exercise> list = [];
  bool done = false;
  List<String> equipment=[];

  fetchExercise() async {
    final response = await http.get(
        'https://wger.de/api/v2/exercise/?category=${widget.workoutID}&status=2&language=2');
    if (response.statusCode == 200) {
      var index = jsonDecode(response.body);
      // If server returns an OK response, parse the JSON.
      if (index['count'] < 20 && index['next'] == null) {
        for (int i = 0; i < index['count']; i++) {
          list.add(Exercise.fromJson(json.decode(response.body), i));
          if(index['results'][i]['equipment'] != null){
            equipment.add(Exercise().checkEquipment(index['results'][i]['equipment'][0]));
          } else equipment.add('none');
        }
      } else {
        final response2 = await http.get(index['next']);
        for (int i = 0; i < 20; i++) {
          list.add(Exercise.fromJson(json.decode(response.body), i));
          if(index['results'][i]['equipment'].length != 0){
            equipment.add(Exercise().checkEquipment(index['results'][i]['equipment'][0]));
          } else equipment.add('none');
        }
        for (int i = 0; i < index['count'] - 20; i++) {
          list.add(Exercise.fromJson(json.decode(response2.body), i));
          if(index['results'][i]['equipment'].length != 0){
            equipment.add(Exercise().checkEquipment(index['results'][i]['equipment'][0]));
          } else equipment.add('none');
        }
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
    fetchExercise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Exercises for ${widget.workout}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: done
          ? ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExerciseDetailsPage(
                                  equipment: equipment[index],
//                        equipment: list[index].equipment,
                                  workout: list[index].exerciseName,
                                  description: list[index].description,
                                  exerciseID: list[index].id,
                                )));
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            '${list[index].exerciseName}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 5,),
                          Text(
                            'Equipment: ${equipment[index]}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
