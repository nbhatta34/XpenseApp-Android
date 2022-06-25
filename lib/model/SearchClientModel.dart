class SearchClientModel {
  final String clientName;
  final String mobile;
  final String address;
  final String email;
  final String clientId;

  SearchClientModel({
    required this.clientName,
    required this.mobile,
    required this.address,
    required this.email,
    required this.clientId,
  });

  factory SearchClientModel.fromJson(Map<String, dynamic> json) =>
      SearchClientModel(
        clientId: json['_id'],
        clientName: json['clientName'],
        mobile: json['mobile'],
        address: json['address'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() => {
        'clientId': clientId,
        'clientName': clientName,
        'mobile': mobile,
        'address': address,
        'email': email,
      };
}
