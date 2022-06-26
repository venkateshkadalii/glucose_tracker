class User {
  int? id;
  String? firstName;
  String? lastName;
  int? age;
  String? gender;
  String? phone;
  String? password;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.age,
    this.gender,
    this.phone,
    this.password,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    age = json['age'];
    gender = json['gender'];
    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['age'] = age;
    data['gender'] = gender;
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }
}
