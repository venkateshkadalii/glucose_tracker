import 'dart:convert';
import 'package:glucose_tracker/src/models/reading.dart';
import 'package:glucose_tracker/src/models/response_model.dart';
import 'package:http/http.dart';

class RemoteServices {
  RemoteServices();

  static final _client = Client();
  static Map<String, String> headers = {"Content-Type": "application/json"};

  // API call for validating login
  Future<ResponseModel> doLogin(
      String username, String password) async {
    var map = {
     "username" : username,
      "password" : password,
    };

    var response = await _client.post(
      getUri("/login"),
      body: json.encode(map),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return ResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  // API call for registering user
  Future<ResponseModel> registerUser(
      String firstName, String lastName, int age, String gender, String password, String phone) async {
    var map = {
      "first_name" : firstName,
      "last_name" : lastName,
      "age": age,
      "gender": gender,
      "phone" : phone,
      "password" : password,
    };

    var response = await _client.post(
      getUri("/registration"),
      body: json.encode(map),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return ResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  // API call for saving reading entry
  Future<ResponseModel> saveReading(
      String date, String type, int value) async {
    var map = {
      "date" : date,
      "type" : type,
      "value": value,
    };

    var response = await _client.post(
      getUri("/save-entry"),
      body: json.encode(map),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return ResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  // API call for getting readings history
  Future<List<Reading>> getReadingHistory(
      String phone) async {
    var map = {
      "phone" : phone,
    };

    var response = await _client.post(
      getUri("/save-entry"),
      body: json.encode(map),
      headers: headers,
    );
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      List<Reading> readings = list.map((model) => Reading.fromJson(model)).toList();
      return readings;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  static Uri getUri(String path) {
    return Uri.parse(path);
  }
}