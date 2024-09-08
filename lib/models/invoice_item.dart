// To parse this JSON data, do
//
//     final invoiceItem = invoiceItemFromJson(jsonString);

import 'dart:convert';

InvoiceItem invoiceItemFromJson(String str) =>
    InvoiceItem.fromJson(json.decode(str));

String invoiceItemToJson(InvoiceItem data) => json.encode(data.toJson());

class InvoiceItem {
  final BigInt? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final BigInt? subscriberId;
  final int? count;
  final double? totalMoney;
  final double? totalPoints;
  final String? status;

  InvoiceItem({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.subscriberId,
    this.count,
    this.totalMoney,
    this.totalPoints,
    this.status,
  });

  InvoiceItem copyWith({
    BigInt? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    BigInt? subscriberId,
    int? count,
    double? totalMoney,
    double? totalPoints,
    String? status,
  }) =>
      InvoiceItem(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        subscriberId: subscriberId ?? this.subscriberId,
        count: count ?? this.count,
        totalMoney: totalMoney ?? this.totalMoney,
        totalPoints: totalPoints ?? this.totalPoints,
        status: status ?? this.status,
      );

  factory InvoiceItem.fromJson(Map<String, dynamic> json) => InvoiceItem(
        id: BigInt.from(json["id"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        subscriberId: BigInt.from(json["subscriber_id"]),
        count: json["count"],
        totalMoney: json["total_money"]?.toDouble(),
        totalPoints: json["total_points"]?.toDouble(),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "subscriber_id": subscriberId,
        "count": count,
        "total_money": totalMoney,
        "total_points": totalPoints,
        "status": status,
      };
}
