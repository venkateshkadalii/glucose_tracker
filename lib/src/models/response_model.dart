class ResponseModel {
  bool? isSuccessful;
  String? message;

  ResponseModel({this.isSuccessful, this.message});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    isSuccessful = json['is_successful'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_successful'] = isSuccessful;
    data['message'] = message;
    return data;
  }
}