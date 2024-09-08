// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? nameAr;
  final String? nameEn;
  final String? image;
  final String? description;

  Category({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.nameAr,
    this.nameEn,
    this.image,
    this.description,
  });

  Category copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? nameAr,
    String? nameEn,
    String? image,
    String? description,
  }) =>
      Category(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        nameAr: nameAr ?? this.nameAr,
        nameEn: nameEn ?? this.nameEn,
        image: image ?? this.image,
        description: description ?? this.description,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        image: json["image"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name_ar": nameAr,
        "name_en": nameEn,
        "image": image,
        "description": description,
      };
}
