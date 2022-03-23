class Food {
  String? name;
  String? image;
  int? times;
  String? eatenDate;
  String? entryDate;

  Food({this.name, this.image, this.times, this.entryDate, this.eatenDate});

  Food.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    times = json['times'];
    eatenDate = json['eatenDate'];
    entryDate = json['entryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['times'] = times;
    data['eatenDate'] = eatenDate;
    data['entryDate'] = entryDate;
    return data;
  }
}
