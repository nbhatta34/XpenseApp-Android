import 'package:xpense_android/response/CurrentUserData.dart';

class ResponseGetUser {
  bool? success;
  String? message;
  CurrentUserData? data;

  ResponseGetUser({this.success, this.message, this.data});

  factory ResponseGetUser.fromJson(Map<String, dynamic> json) {
    return ResponseGetUser(
      success: json['success'],
      message: json['message'],
      data: CurrentUserData.fromJson(
        json['data'],
      ),
    );
  }
}
