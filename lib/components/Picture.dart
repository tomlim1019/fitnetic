class Picture {
  final String image;

  Picture({this.image});

  factory Picture.fromJson(Map<String, dynamic> json, int i) {
    return Picture(
      image: json['results'][i]['image'],
    );
  }
}