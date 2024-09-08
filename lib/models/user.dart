// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

class User {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? email;
  String? avatar;
  String? subscription;
  Details? details;
  String? subscriberId;
  String? address;
  String? phone;
  String? token;
  String? result;

  User({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.email,
    this.avatar,
    this.subscription,
    this.details,
    this.subscriberId,
    this.address,
    this.phone,
    this.token,
    this.result,
  });

  User copyWith({
    String? id,
    String? createdAt,
    String? updatedAt,
    String? name,
    String? email,
    String? avatar,
    String? subscription,
    Details? details,
    String? subscriberId,
    String? address,
    String? phone,
    String? token,
    String? result,
  }) =>
      User(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        name: name ?? this.name,
        email: email ?? this.email,
        avatar: avatar ?? this.avatar,
        subscription: subscription ?? this.subscription,
        details: details ?? this.details,
        subscriberId: subscriberId ?? this.subscriberId,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        token: token ?? this.token,
        result: result ?? this.result,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"].toString(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        name: json["name"]??'',
        email: json["email"],
        avatar: json["avatar"],
        subscription: json["subscription"],
        details:
            json["details"] == null ? null : Details.fromJson(json["details"]),
        subscriberId: json["subscriber_id"].toString(),
        address: json["address"]??'',
        phone: json["phone"]??'',
        token: json["token"],
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "name": name,
        "email": email,
        "avatar": avatar,
        "subscription": subscription,
        "details": details?.toJson(),
        "subscriber_id": subscriberId,
        "address": address,
        "phone": phone,
        "token": token,
        "result": result,
      };
}

class Details {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? subscriberId;
  String? address;
  String? phone;

  Details({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.subscriberId,
    this.address,
    this.phone,
  });

  Details copyWith({
    String? id,
    String? createdAt,
    String? updatedAt,
    String? subscriberId,
    String? address,
    String? phone,
  }) =>
      Details(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        subscriberId: subscriberId ?? this.subscriberId,
        address: address ?? this.address,
        phone: phone ?? this.phone,
      );

  factory Details.fromRawJson(String str) => Details.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"].toString(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        subscriberId: json["subscriber_id"].toString(),
        address: json["address"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "subscriber_id": subscriberId,
        "address": address,
        "phone": phone,
      };
}
