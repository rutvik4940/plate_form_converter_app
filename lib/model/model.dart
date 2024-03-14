class DataModel {
  String? name, email,call, image,date,time;

  DataModel(
      {required this.name,
        required this.email,
        required this.call,
        required this.date,
        required this.time,
        required this.image});

  factory DataModel.fromMap(Map m1) {
    return DataModel(
      name: m1['name'],
      email: m1['email'],
      call: m1['contact'],
      image: m1['image'],
      date: m1['date'],
      time: m1['time'],

    );
  }
}
