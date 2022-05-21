class AllTransaction {
  final String? itemName;
  final String? quantity;
  final String? unitPrice;
  final String? category;
  final String? clientName;
  final String? createdAt;
  final String? transactionId;

  AllTransaction({
    this.itemName,
    this.quantity,
    this.unitPrice,
    this.category,
    this.clientName,
    this.createdAt,
    this.transactionId,
  });

  factory AllTransaction.fromJson(Map<String, dynamic> json) {
    return AllTransaction(
      itemName: json['itemName'],
      quantity: json['quantity'],
      unitPrice: json['unitPrice'],
      category: json['category'],
      clientName: json['clientName'],
      createdAt: json['createdAt'],
      transactionId: json['_id'],
    );
  }
}
