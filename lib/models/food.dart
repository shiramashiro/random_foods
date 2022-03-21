class Food {
  String? name;
  String? image;
  int? times;
  String? datetime;

  Food({this.name, this.image, this.times, this.datetime});

  Food.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    times = json['times'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['times'] = times;
    data['datetime'] = datetime;
    return data;
  }
}