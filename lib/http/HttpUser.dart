import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:xpense_android/model/CategoryModel.dart';
import 'package:xpense_android/model/ClientModel.dart';
import 'package:xpense_android/model/SearchTransactions.dart';
import 'package:xpense_android/model/SearchClientModel.dart';
import 'package:xpense_android/model/StockModel.dart';
import 'package:xpense_android/model/SupplierModel.dart';
import 'package:xpense_android/model/TransactionModel.dart';
import 'package:xpense_android/model/UserModel.dart';
import 'package:xpense_android/model/UserProfile.dart';
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
  // ++++++++++++++++++++++++++++++++ Get Current User Data ++++++++++++++++++++++++++++++++++++++++

  Future getCurrentUser(String url) async {
    String tok = 'Bearer $token';
    var response = await http.get(Uri.parse(baseurl + url), headers: {
      'Authorization': tok,
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed To Load User Data');
    }
  }

  // +++++++++++++++++++++++++++++++ UPLOAD PROFILE IMAGE ++++++++++++++++++++++++++++++++++++++++++

  Future<String> uploadImage(String filepath, String id) async {
    print("Upload Image function ma pugyo");
    print(filepath);
    print(id);
    try {
      String tok = 'Bearer $token';
      String route = 'auth/' + id + '/photo';
      print(route);
      String url = baseurl + route;
      var request = http.MultipartRequest('PUT', Uri.parse(url));
      //using the token in the headers
      request.headers.addAll({
        'Authorization': tok,
      });
      // need a filename

      var ss = filepath.split('/').last;
      print(ss);
      // adding the file in the request
      request.files.add(
        http.MultipartFile(
          'file',
          File(filepath).readAsBytes().asStream(),
          File(filepath).lengthSync(),
          filename: ss,
        ),
      );

      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        return 'ok';
      }
    } catch (err) {
      print('$err');
    }
    return 'something goes wrong';
  }

  // +++++++++++++++++++++++++++++++ Update User Profile +++++++++++++++++++++++++++++++++++++++++++++

  void updateProfile(UserProfile updateUser, File? file) async {
    print(file);
    String s = '';
    String tok = 'Bearer $token';
    print("Profile Data Reached Update Profile HTTP Function");
    Map<String, dynamic> userMap = {
      "fname": updateUser.firstname,
      "lname": updateUser.lastname,
      "mobile": updateUser.mobile,
      "address": updateUser.address,
      "businessName": updateUser.businessName,
      "pan_vat_no": updateUser.pan_vat_no,
    };

    final response = await http.put(Uri.parse(baseurl + 'auth/profile/'),
        headers: {'Authorization': tok}, body: userMap);
    if (response.statusCode == 200) {
      print("status code 200 aayo");
      if (file != null) {
        print("image file null xaina");
        print(file);
        var jsonData = jsonDecode(response.body);
        print(jsonData["_id"]);
        var s = await uploadImage(file.path, jsonData['_id']);
      }
      if (s == "ok") {
        Fluttertoast.showToast(msg: "Data uploaded successfully");
      }
    } else {}
  }
  // ++++++++++++++++++++++++++++++++ Add Client Information  ++++++++++++++++++++++++++++++++++++++++

  Future<bool> addClientInformation(Clients client) async {
    String tok = 'Bearer $token';
    Map<String, dynamic> clientMap = {
      "clientName": client.clientName,
      "mobile": client.mobile,
      "address": client.address,
      "email": client.email,
    };

    // print("Transaction Map: ${transactionMap}");

    final response = await http.post(
        Uri.parse(baseurl + 'auth/addClientInformation/'),
        body: clientMap,
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

  // ++++++++++++++++++++++++++++++++ Get All Client Data ++++++++++++++++++++++++++++++++++++++++

  Future viewClientInformation(String url) async {
    String tok = 'Bearer $token';
    var response = await http.get(Uri.parse(baseurl + url), headers: {
      'Authorization': tok,
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed To Load Client Information');
    }
  }
// ++++++++++++++++++++++++++++++++ Add Category  ++++++++++++++++++++++++++++++++++++++++

  Future<bool> addCategory(Category category, File? file) async {
    print(file);
    String s = '';
    String tok = 'Bearer $token';
    Map<String, dynamic> categoryMap = {
      "categoryName": category.categoryName,
    };

    final response = await http.post(Uri.parse(baseurl + 'auth/addCategory/'),
        body: categoryMap,
        headers: {
          'Authorization': tok,
        });
    var jsonData = jsonDecode(response.body);
    // print(jsonData["status"]);
    // print(response.body);
    if (jsonData["status"] == "200") {
      print(response.body);
      // var usrRes = ResponseUser.fromJson(jsonDecode(response.body));
      var categoryId = jsonData["category"]["_id"];
      var categoryName = jsonData["category"]["categoryName"];
      print(categoryId);
      if (file != null) {
        print("image file null xaina");
        print(file);
        // var jsonData = jsonDecode(response.body);
        // print(jsonData["_id"]);
        var s = await uploadThumbnail(file.path, categoryId, categoryName);
      }
      if (s == "ok") {
        Fluttertoast.showToast(msg: "Data uploaded successfully");
      } else {}
      return true;
    } else {
      return false;
    }
  }

  // ++++++++++++++++++++++++++++++++ Get Category Data ++++++++++++++++++++++++++++++++++++++++

  Future viewCategory(String url) async {
    String tok = 'Bearer $token';
    var response = await http.get(Uri.parse(baseurl + url), headers: {
      'Authorization': tok,
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed To Load Category');
    }
  }

  // +++++++++++++++++++++++++++++++ UPLOAD CATEGORY THUMBNAIL IMAGE ++++++++++++++++++++++++++++++++++++++++++

  Future<String> uploadThumbnail(
      String filepath, String categoryId, String categoryName) async {
    print("Upload Thumbnail function ma pugyo");
    print(filepath);
    print(categoryId);
    try {
      String tok = 'Bearer $token';
      String route = 'auth/' + categoryId + '/' + categoryName + '/photo';
      print(route);
      String url = baseurl + route;
      var request = http.MultipartRequest('POST', Uri.parse(url));
      //using the token in the headers
      request.headers.addAll({
        'Authorization': tok,
      });
      // need a filename

      var ss = filepath.split('/').last;
      print(ss);
      // adding the file in the request
      request.files.add(
        http.MultipartFile(
          'file',
          File(filepath).readAsBytes().asStream(),
          File(filepath).lengthSync(),
          filename: ss,
        ),
      );

      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        return 'ok';
      }
    } catch (err) {
      print('$err');
    }
    return 'something goes wrong';
  }
  // +++++++++++++++++++++++++++++++ Delete Client Details +++++++++++++++++++++++++++++++++++++++++++++

  void deleteClientInformation(String clientId) async {
    String tok = 'Bearer $token';

    final response = await http.delete(
        Uri.parse(baseurl + 'auth/deleteClientInformation/${clientId}'),
        headers: {'Authorization': tok});
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Client Information Deleted",
        backgroundColor: Colors.green,
        fontSize: 16,
        gravity: ToastGravity.TOP,
      );
    } else {}
  }
// ------------------------------------------------------------------------------------------------------
// +++++++++++++++++++++++++++++++ Delete Category Details +++++++++++++++++++++++++++++++++++++++++++++

  void deleteCategory(String categoryId) async {
    String tok = 'Bearer $token';

    final response = await http.delete(
        Uri.parse(baseurl + 'auth/deleteCategory/${categoryId}'),
        headers: {'Authorization': tok});
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Category Deleted",
        backgroundColor: Colors.green,
        fontSize: 16,
        gravity: ToastGravity.TOP,
      );
    } else {}
  }
// -------------------------------------------------------------------------------------------------------
// ++++++++++++++++++++++++++++++++ Add Supplier Information  ++++++++++++++++++++++++++++++++++++++++

  Future<bool> addSupplierInformation(Suppliers supplier) async {
    String tok = 'Bearer $token';
    Map<String, dynamic> supplierMap = {
      "supplierName": supplier.supplierName,
      "mobile": supplier.mobile,
      "address": supplier.address,
      "email": supplier.email,
    };

    final response = await http.post(
        Uri.parse(baseurl + 'auth/addSupplierInformation/'),
        body: supplierMap,
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
  // ++++++++++++++++++++++++++++++++ Get All Supplier Data ++++++++++++++++++++++++++++++++++++++++

  Future viewSupplierInformation(String url) async {
    String tok = 'Bearer $token';

    var response = await http.get(Uri.parse(baseurl + url), headers: {
      'Authorization': tok,
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed To Load Supplier Information');
    }
  }
  // ++++++++++++++++++++++++++++++++ Add Stock Category  ++++++++++++++++++++++++++++++++++++++++

  Future<bool> addStockCategory(Category category, File? file) async {
    print("file");
    String s = '';
    String tok = 'Bearer $token';
    Map<String, dynamic> categoryMap = {
      "categoryName": category.categoryName,
    };

    final response = await http.post(
        Uri.parse(baseurl + 'auth/addStockCategory/'),
        body: categoryMap,
        headers: {
          'Authorization': tok,
        });
    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "200") {
      print(response.body);
      var categoryId = jsonData["stockCategory"]["_id"];
      var categoryName = jsonData["stockCategory"]["categoryName"];
      print(categoryId);
      if (file != null) {
        print("image file null xaina");
        print(file);
        var s = await uploadThumbnail(file.path, categoryId, categoryName);
      }
      if (s == "ok") {
        Fluttertoast.showToast(msg: "Data uploaded successfully");
      } else {}
      return true;
    } else {
      return false;
    }
  }
  //--------------------------------------------------------------------------------------------

  // ++++++++++++++++++++++++++++++++ Get Stock Category Data ++++++++++++++++++++++++++++++++++++++++

  Future viewStockCategory(String url) async {
    String tok = 'Bearer $token';
    var response = await http.get(Uri.parse(baseurl + url), headers: {
      'Authorization': tok,
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed To Load Supplier Information');
    }
  }
// -----------------------------------------------------------------------------------------------------
// +++++++++++++++++++++++++++++++ Delete Supplier Details +++++++++++++++++++++++++++++++++++++++++++++

  void deleteSupplierInformation(String supplierId) async {
    String tok = 'Bearer $token';

    final response = await http.delete(
        Uri.parse(baseurl + 'auth/deleteSupplierInformation/${supplierId}'),
        headers: {'Authorization': tok});

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Supplier Information Deleted",
        backgroundColor: Colors.green,
        fontSize: 16,
        gravity: ToastGravity.TOP,
      );
    } else {}
  }

// -------------------------------------------------------------------------------------------------------
  // +++++++++++++++++++++++++++++++ UPLOAD STOCK CATEGORY THUMBNAIL IMAGE ++++++++++++++++++++++++++++++++++++++++++

  Future<String> uploadStockThumbnail(
      String filepath, String categoryId, String categoryName) async {
    print("Upload Thumbnail function ma pugyo");
    print(filepath);
    print(categoryId);
    try {
      String tok = 'Bearer $token';
      String route = 'auth/' + categoryId + '/' + categoryName + '/photo';
      print(route);
      String url = baseurl + route;
      var request = http.MultipartRequest('POST', Uri.parse(url));
      //using the token in the headers
      request.headers.addAll({
        'Authorization': tok,
      });
      // need a filename

      var ss = filepath.split('/').last;
      print(ss);
      // adding the file in the request
      request.files.add(
        http.MultipartFile(
          'file',
          File(filepath).readAsBytes().asStream(),
          File(filepath).lengthSync(),
          filename: ss,
        ),
      );

      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        return 'ok';
      }
    } catch (err) {
      print('$err');
    }
    return 'something goes wrong';
  }
  // +++++++++++++++++++++++++++++++ Delete Stock Category Details +++++++++++++++++++++++++++++++++++++++++++++

  void deleteStockCategory(String categoryId) async {
    print(categoryId);
    String tok = 'Bearer $token';

    final response = await http.delete(
        Uri.parse(baseurl + 'auth/deleteStockCategory/${categoryId}'),
        headers: {'Authorization': tok});
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Category Deleted",
        backgroundColor: Colors.green,
        fontSize: 16,
        gravity: ToastGravity.TOP,
      );
    } else {}
  }
// -------------------------------------------------------------------------------------------------------
// ++++++++++++++++++++++++++++++     SEARCH ANY TRANSACTIONS      ++++++++++++++++++++++++++++++++++++++++++

  Future searchUSer(String query) async {
    String tok = 'Bearer $token';
    final url = Uri.parse(baseurl + "auth/searchTransaction/");
    final response = await http.get(url, headers: {'Authorization': tok});

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users
          .map((json) => SearchTransactions.fromJson(json))
          .where((user) {
        final fnameLower = user.clientName.toLowerCase();
        final searchLower = query.toLowerCase();

        return fnameLower.contains(searchLower);
      });
    }
  }
  // ++++++++++++++++++++++++++++++     SEARCH ANY CLIENT      ++++++++++++++++++++++++++++++++++++++++++

  Future searchClientInfo(String query) async {
    String tok = 'Bearer $token';
    final url = Uri.parse(baseurl + "auth/searchClientInfo/");
    final response = await http.get(url, headers: {'Authorization': tok});

    if (response.statusCode == 200) {
      final List clients = json.decode(response.body);

      return clients.map((json) => SearchClientModel.fromJson(json)).where(
        (user) {
          final clientName = user.clientName.toLowerCase();
          final mobile = user.mobile.toLowerCase();
          final address = user.address.toLowerCase();
          final email = user.email.toLowerCase();
          final searchLower = query.toLowerCase();

          return clientName.contains(searchLower) ||
              mobile.contains(searchLower) ||
              address.contains(searchLower) ||
              email.contains(searchLower);
        },
      ).toList();
    } else {
      throw Exception();
    }
  }

  // +++++++++++++++++++++++++++++++++   ADD DOCUMENTS (MULTIPLE FILE UPLOAD)     +++++++++++++++++++++++++++++++++++

  addDocuments(List<File> files) async {
    List<File> pickedFile = files;

    print(pickedFile[0]);

    String tok = 'Bearer $token';

    // create multipart request
    var request =
        http.MultipartRequest('POST', Uri.parse(baseurl + "auth/addDocuments"));

    request.headers.addAll({
      'Authorization': tok,
    });

    if (pickedFile.length > 0) {
      for (var i = 0; i < pickedFile.length; i++) {
        request.files.add(
          http.MultipartFile(
              'picture',
              File(pickedFile[i].path).readAsBytes().asStream(),
              File(pickedFile[i].path).lengthSync(),
              filename: pickedFile[i].path.split("/").last),
        );
      }

      // send
      var response = await request.send();

      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        debugPrint(value);
        //  _submitedSuccessfully(context);
      });
    }
  }

  // +++++++++++++++++++++++++++++++++   FETCH ALL USER DOCUMENTS    +++++++++++++++++++++++++++++++++++

  fetchDocuments() async {
    String tok = 'Bearer $token';
    try {
      var documents =
          await http.get(Uri.parse(baseurl + "auth/fetchDocuments"), headers: {
        'Authorization': tok,
      });
      // print(jsonDecode(documents.body)["data"]);
      return jsonDecode(documents.body)["data"];
    } catch (e) {
      print(e);
    }
  }

  // +++++++++++++++++++++++++++++++ DELETE DOCUMENT +++++++++++++++++++++++++++++++++++++++++++++

  void deleteDocument(String documentId) async {
    print(documentId);
    String tok = 'Bearer $token';

    final response = await http.delete(
        Uri.parse(baseurl + 'auth/deleteDocument/${documentId}'),
        headers: {'Authorization': tok});
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Document Deleted",
        backgroundColor: Colors.green,
        fontSize: 16,
        gravity: ToastGravity.TOP,
      );
    } else {}
  }
}
