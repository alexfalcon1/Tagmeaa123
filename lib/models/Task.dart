// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

import 'dart:convert';

class Task {
  final int id;
  final int cartId;
  final int driverId;
  final DateTime dueDate;
  final String pickupAddress;
  final String status;
  final int rate;
  final String subscriberName;

  Task({
    required this.id,
    required this.cartId,
    required this.driverId,
    required this.dueDate,
    required this.pickupAddress,
    required this.status,
    required this.rate,
    required this.subscriberName,
  });

  Task copyWith({
    int? id,
    int? cartId,
    int? driverId,
    DateTime? dueDate,
    String? pickupAddress,
    String? status,
    int? rate,
    String? subscriberName,
  }) =>
      Task(
        id: id ?? this.id,
        cartId: cartId ?? this.cartId,
        driverId: driverId ?? this.driverId,
        dueDate: dueDate ?? this.dueDate,
        pickupAddress: pickupAddress ?? this.pickupAddress,
        status: status ?? this.status,
        rate: rate ?? this.rate,
        subscriberName: subscriberName ?? this.subscriberName,
      );

  factory Task.fromRawJson(String str) => Task.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        cartId: json["cart_id"],
        driverId: json["driver_id"],
        dueDate: DateTime.parse(json["due_date"]),
        pickupAddress: json["pickup_address"],
        status: json["status"],
        rate: json["rate"],
        subscriberName: json["subscriber_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cart_id": cartId,
        "driver_id": driverId,
        "due_date": dueDate.toIso8601String(),
        "pickup_address": pickupAddress,
        "status": status,
        "rate": rate,
        "subscriber_name": subscriberName,
      };
}
