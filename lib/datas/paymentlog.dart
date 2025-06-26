class PaymentLog {
  final int? id;
  final int orderId;
  final String direction; // 'sent' or 'received'
  final String payload;
  final String createdAt;

  PaymentLog({
    this.id,
    required this.orderId,
    required this.direction,
    required this.payload,
    required this.createdAt,
  });

  factory PaymentLog.fromMap(Map<String, dynamic> map) {
    return PaymentLog(
      id: map['id'],
      orderId: map['order_id'],
      direction: map['direction'],
      payload: map['payload'],
      createdAt: map['created_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_id': orderId,
      'direction': direction,
      'payload': payload,
      'created_at': createdAt,
    };
  }
}
