class Food {
  int? id;
  String? name;
  double? price;
  double? star;
  String? image;
  int? times;
  String? eatenDate;
  String? entryDate;

  Food({this.name, this.image, this.times, this.entryDate, this.eatenDate});

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    times = json['times'];
    price = json['price'];
    star = json['star'];
    eatenDate = json['eatenDate'];
    entryDate = json['entryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['times'] = times;
    data['price'] = price;
    data['star'] = star;
    data['eatenDate'] = eatenDate;
    data['entryDate'] = entryDate;
    return data;
  }
}
