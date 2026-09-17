class OrderIdModel {
  final String id;
  final bool deliveryNeeded;
  final double amountCents;

  OrderIdModel({
    required this.id,
    required this.deliveryNeeded,
    required this.amountCents,
  });

  factory OrderIdModel.fromJson(Map<String, dynamic> json) {
    return OrderIdModel(
      id: json['id'].toString(),
      deliveryNeeded: json['delivery_needed'] ?? false,
      amountCents: (json['amount_cents'] as num?)?.toDouble() ?? 0,
    );
  }
}