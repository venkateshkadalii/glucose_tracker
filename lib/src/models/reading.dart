import 'package:glucose_tracker/src/models/user.dart';

class Reading {
  String? type;
  int? value;
  String? date;
  String? phone;

  Reading({
    this.type,
    this.value,
    this.date,
    this.phone,
  });

  Reading.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
    date = json['date'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    data['date'] = date;
    data['phone'] = phone;
    return data;
  }
}
