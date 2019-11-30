class Workout {
  final int id;
  final String musclePart;

  Workout({this.id, this.musclePart});

  factory Workout.fromJson(Map<String, dynamic> json, int i) {
    return Workout(
      id: json['results'][i]['id'],
      musclePart: json['results'][i]['name'],
    );
  }
}

