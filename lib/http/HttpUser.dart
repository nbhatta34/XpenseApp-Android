import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:xpense_android/model/StockModel.dart';
import 'package:xpense_android/model/TransactionModel.dart';
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
        await http.post(Uri.parse(baseurl + 'auth/register/'), body: userMap);
    if (response.statusCode == 200) {
      var usrRes = ResponseUser.fromJson(jsonDecode(response.body));
      return usrRes.success!;
    } else {
      return false;
    }
  }

// +++++++++++++++++++++++++++++++++   Login     Function     +++++++++++++++++++++++++++++++++++
  Future<bool> loginPosts(String email, String password) async {
    // print("Data Reached Login");
    // print(email + password);
    Map<String, dynamic> loginUser = {'email': email, 'password': password};

    try {
      // print("login server");
      final response = await http.post(
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

// ++++++++++++++++++++++++++++++++ Add Transaction  ++++++++++++++++++++++++++++++++++++++++

  Future<bool> addTransaction(Transaction trans) async {
    String tok = 'Bearer $token';
    Map<String, dynamic> transactionMap = {
      "itemName": trans.itemName,
      "quantity": trans.quantity,
      "unitPrice": trans.unitPrice,
      "category": trans.category,
      "clientName": trans.clientName,
    };

    // print("Transaction Map: ${transactionMap}");

    final response = await http.post(
        Uri.parse(baseurl + 'auth/addTransaction/'),
        body: transactionMap,
        headers: {
          'Authorization': tok,
        });
    if (response.statusCode == 200) {
      var usrRes = ResponseUser.fromJson(jsonDecode(response.body));
      return usrRes.success!;
    } else {
      return false;
    }
  }

// ++++++++++++++++++++++++++++++++ Get All Transaction Data ++++++++++++++++++++++++++++++++++++++++

  Future viewTransactions(String url) async {
    String tok = 'Bearer $token';
    var response = await http.get(Uri.parse(baseurl + url), headers: {
      'Authorization': tok,
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed To Load Transactions');
    }
  }

// +++++++++++++++++++++++++++++++ Delete Transaction Details +++++++++++++++++++++++++++++++++++++++++++++

  void deleteTransaction(String transactionId) async {
    String tok = 'Bearer $token';
    // print("Profile Data Reached Delete Transaction HTTP Function");

    final response = await http.delete(
        Uri.parse(baseurl + 'auth/updateTransaction/${transactionId}'),
        headers: {'Authorization': tok});
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Transaction Deleted",
        backgroundColor: Colors.green,
        fontSize: 16,
        gravity: ToastGravity.TOP,
      );
    } else {}
  }

  // +++++++++++++++++++++++++++++++ Update Transaction Details +++++++++++++++++++++++++++++++++++++++++++++

  void updateTransaction(
      Transaction updateTransaction, String transactionId) async {
    // print(transactionId);
    // print(updateTransaction.clientName);
    String tok = 'Bearer $token';
    // print("Profile Data Reached Update Transaction HTTP Function");

    Map<String, dynamic> transMap = {
      "itemName": updateTransaction.itemName,
      "quantity": updateTransaction.quantity,
      "unitPrice": updateTransaction.unitPrice,
      "category": updateTransaction.category,
      "clientName": updateTransaction.clientName,
    };

    final response = await http.put(
        Uri.parse(baseurl + 'auth/updateTransaction/${transactionId}'),
        headers: {'Authorization': tok},
        body: transMap);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Transaction Updated",
        backgroundColor: Colors.green,
        fontSize: 16,
        gravity: ToastGravity.TOP,
      );
    } else {}
  }

// +++++++++++++++++++++++++++++++ Adding Stock Details +++++++++++++++++++++++++++++++++++++++++++++
  Future<bool> addStock(Stock stoc) async {
    String tok = 'Bearer $token';
    Map<String, dynamic> stockMap = {
      "stockName": stoc.stockName,
      "quantity": stoc.quantity,
      "unitPrice": stoc.unitPrice,
      "category": stoc.category,
      "supplierName": stoc.supplierName,
    };
    // print("Transaction Map: ${transactionMap}");
    final response = await http
        .post(Uri.parse(baseurl + 'auth/addStock'), body: stockMap, headers: {
      'Authorization': tok,
    });
    if (response.statusCode == 200) {
      var usrRes = ResponseUser.fromJson(jsonDecode(response.body));
      return usrRes.success!;
    } else {
      return false;
    }
  }

  // ++++++++++++++++++++++++++++++++ Get All Stock Data ++++++++++++++++++++++++++++++++++++++++

  Future viewStocks(String url) async {
    String tok = 'Bearer $token';
    var response = await http.get(Uri.parse(baseurl + url), headers: {
      'Authorization': tok,
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed To Load Stocks');
    }
  }
  // +++++++++++++++++++++++++++++++ Delete Transaction Details +++++++++++++++++++++++++++++++++++++++++++++

  void deleteStock(String stockId) async {
    String tok = 'Bearer $token';
    // print("Profile Data Reached Delete Transaction HTTP Function");

    final response = await http.delete(
        Uri.parse(baseurl + 'auth/updateStock/${stockId}'),
        headers: {'Authorization': tok});
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Stock Deleted",
        backgroundColor: Colors.green,
        fontSize: 16,
        gravity: ToastGravity.TOP,
      );
    } else {}
  }
  // +++++++++++++++++++++++++++++++ Update Stock Details +++++++++++++++++++++++++++++++++++++++++++++

  void updateStock(Stock updateStock, String stockId) async {
    // print(transactionId);
    // print(updateTransaction.clientName);
    String tok = 'Bearer $token';
    // print("Profile Data Reached Update Transaction HTTP Function");

    Map<String, dynamic> transMap = {
      "stockName": updateStock.stockName,
      "quantity": updateStock.quantity,
      "unitPrice": updateStock.unitPrice,
      "category": updateStock.category,
      "supplierName": updateStock.supplierName,
    };

    final response = await http.put(
        Uri.parse(baseurl + 'auth/updateStock/${stockId}'),
        headers: {'Authorization': tok},
        body: transMap);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Stock Updated",
        backgroundColor: Colors.green,
        fontSize: 16,
        gravity: ToastGravity.TOP,
      );
    } else {}
  }
}
