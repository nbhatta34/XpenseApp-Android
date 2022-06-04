class ClientResponse {
  String? clientName;

  ClientResponse({this.clientName});

  factory ClientResponse.fromJson(Map<String, dynamic> json) {
    return ClientResponse(
      clientName: json['clientName'],
    );
  }
}
