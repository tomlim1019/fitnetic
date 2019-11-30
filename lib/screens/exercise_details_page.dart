import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fitnetic/components/Picture.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ExerciseDetailsPage extends StatefulWidget {
  ExerciseDetailsPage(
      {@required this.equipment,
      @required this.workout,
      @required this.description,
      @required this.exerciseID});
  final String equipment;
  final String workout;
  final String description;
  final int exerciseID;
  @override
  _ExerciseDetailsPageState createState() => _ExerciseDetailsPageState();
}

class _ExerciseDetailsPageState extends State<ExerciseDetailsPage> {
  List<Picture> list = [];
  bool done = false;

  fetchPicture() async {
    final response = await http.get(
        'https://wger.de/api/v2/exerciseimage/?exercise=${widget.exerciseID}');
    if (response.statusCode == 200) {
      var index = jsonDecode(response.body);
      for (int i = 0; i < index['count']; i++) {
        list.add(Picture.fromJson(json.decode(response.body), i));
      }
      print(list.length);
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
    fetchPicture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.workout,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Exercise Name: ',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.workout,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Equipment: ',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.equipment,
                  style: TextStyle(
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Description:',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.description,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Pictures:',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                done
                    ? Expanded(
                        child: list.length == 0
                            ? Center(
                                child: Text(
                                  'No image Available',
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            : GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                children: List.generate(list.length, (index) {
                                  return Image.network(list[index].image);
                                }),
                              ),
                      )
                    : Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ],
            ),
          ),
        ));
  }
}
