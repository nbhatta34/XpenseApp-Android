import 'GetAllTransaction.dart';

class TransactionResponse {
  bool? success;
  String? message;
  AllTransaction? data;

  TransactionResponse({this.success, this.message, this.data});

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      success: json['success'],
      message: json['message'],
      data: AllTransaction.fromJson(
        json['data'][1],
      ),
    );
  }
}
