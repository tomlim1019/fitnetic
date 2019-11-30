class Exercise {
  final int id;
  final String exerciseName;
  final String description;
  final int equipment;

  Exercise({this.id, this.exerciseName, this.description, this.equipment});

  factory Exercise.fromJson(Map<String, dynamic> json, int i) {
    return Exercise(
      id: json['results'][i]['id'],
      exerciseName: json['results'][i]['name'],
      description: json['results'][i]['description'],
//      equipment: json['results'][i]['equipment'][0],
    );
  }

  checkEquipment(id) {
    var equipment = [
      'Barbell',
      'Dumbbell',
      'Gym mat',
      'Kettlebell',
      'Bodyweight',
      'Pull-up bar',
      'Swiss Bar',
      'SZ-Bar'
    ];
    if (id == 1) {
      return equipment[0];
    } else if (id == 3) {
      return equipment[1];
    } else if (id == 4) {
      return equipment[2];
    } else if (id == 10) {
      return equipment[3];
    } else if (id == 7) {
      return equipment[4];
    } else if (id == 6) {
      return equipment[5];
    } else if (id == 5) {
      return equipment[6];
    } else if (id == 2) {
      return equipment[7];
    } else return '';
  }
}
