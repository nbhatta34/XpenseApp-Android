import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:xpense_android/model/UserModel.dart';
import 'package:xpense_android/response/ResponseUser.dart';


class HttpConnectUser {
  Future<http.Response> get(String endpoint) async {
    var url = Uri.parse(endpoint);
    var response = await http.get(url);
    return response;
  }

// +++++++++++++++++++++++++++++++++     Register  User  Function     ++++++++++++++++++++++++++++
  String baseurl = 'http://10.0.2.2:3000/';
  static String token = '';

  //sending data to the server--- creating user
  Future<bool> registerPost(User user) async {
    Map<String, dynamic> userMap = {
      "email": user.email,
      "fname": user.firstname,
      "lname": user.lastname,
      "password": user.password,
    };

    // print("User Map: ${userMap}");

    final response =
        await post(Uri.parse(baseurl + 'auth/register/'), body: userMap);
    if (response.statusCode == 200) {
      var usrRes = ResponseUser.fromJson(jsonDecode(response.body));
      return usrRes.success!;
    } else {
      return false;
    }
  }
}
