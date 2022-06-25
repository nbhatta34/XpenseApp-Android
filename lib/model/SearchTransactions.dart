class SearchTransactions {
  final String itemName;
  final String quantity;
  final String unitPrice;
  final String category;
  final String clientName;
  final String createdAt;
  final String transactionId;
  final String userId;

  SearchTransactions({
    required this.itemName,
    required this.quantity,
    required this.unitPrice,
    required this.category,
    required this.clientName,
    required this.createdAt,
    required this.transactionId,
    required this.userId,
  });

  factory SearchTransactions.fromJson(Map<String, dynamic> json) =>
      SearchTransactions(
        transactionId: json['_id'],
        itemName: json['itemName'],
        quantity: json['quantity'],
        unitPrice: json['unitPrice'],
        category: json['category'],
        clientName: json['clientName'],
        createdAt: json['createdAt'],
        userId: json['userId'],
      );

  Map<String, dynamic> toJson() => {
        'transactionId': transactionId,
        'itemName': itemName,
        'quantity': quantity,
        'unitPrice': unitPrice,
        'category': category,
        'clientName': clientName,
        'createdAt': createdAt,
        'userId': userId,
      };
}
