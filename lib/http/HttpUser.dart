import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class HttpConnectUser {
  Future<http.Response> get(String endpoint) async {
    var url = Uri.parse(endpoint);
    var response = await http.get(url);
    return response;
  }

// +++++++++++++++++++++++++++++++++     Register  User  Function     ++++++++++++++++++++++++++++
  String baseurl = 'http://10.0.2.2:3000/';
  static String token = '';

  Future<bool> loginPosts(String email, String password) async {
    // print("Data Reached Login");
    // print(email + password);
    Map<String, dynamic> loginUser = {'email': email, 'password': password};

    try {
      // print("login server");
      final response = await post(
          Uri.parse(
            baseurl + "auth/login",
          ),
          body: loginUser);

      // print(response.body);

      //json serializing inline
      final jsonData = jsonDecode(response.body) as Map;

      token = jsonData['token'];

      if (jsonData['success']) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
