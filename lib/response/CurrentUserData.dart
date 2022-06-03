import 'package:math_expressions/math_expressions.dart';

class CurrentUserData {
  final String? fname;
  final String? lname;
  final String? email;
  final String? createdAt;
  final String? address;
  final String? pan_vat_no;
  final String? businessName;

  final String? mobile;
  final String? picture;

  CurrentUserData({
    this.fname,
    this.lname,
    this.email,
    this.createdAt,
    this.mobile,
    this.address,
    this.picture,
    this.pan_vat_no,
    this.businessName,
  });

  factory CurrentUserData.fromJson(Map<String, dynamic> json) {
    return CurrentUserData(
        fname: json['fname'],
        lname: json['lname'],
        email: json['email'],
        address: json['address'],
        mobile: json['mobile'],
        createdAt: json['createdAt'],
        picture: json['picture'],
        businessName: json["businessName"],
        pan_vat_no: json["pan_vat_no"]);
  }
}
