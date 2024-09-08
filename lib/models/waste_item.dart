// To parse this JSON data, do
//
//     final wasteItem = wasteItemFromJson(jsonString);

import 'dart:convert';

WasteItem wasteItemFromJson(String str) => WasteItem.fromJson(json.decode(str));

String wasteItemToJson(WasteItem data) => json.encode(data.toJson());

class WasteItem {
  final int? id;
  final String? nameAr;
  final String? nameEn;
  final String? image;
  final String? points;
  final String? description;
  final int? unitId;
  final int? categoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? unitNameAr;
  final String? unitNameEn;
  final String? categoryNameAr;
  final String? categoryNameEn;

  WasteItem({
    this.id,
    this.nameAr,
    this.nameEn,
    this.image,
    this.points,
    this.description,
    this.unitId,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.unitNameAr,
    this.unitNameEn,
    this.categoryNameAr,
    this.categoryNameEn,
  });

  WasteItem copyWith({
    int? id,
    String? nameAr,
    String? nameEn,
    String? image,
    String? points,
    String? description,
    int? unitId,
    int? categoryId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? unitNameAr,
    String? unitNameEn,
    String? categoryNameAr,
    String? categoryNameEn,
  }) =>
      WasteItem(
        id: id ?? this.id,
        nameAr: nameAr ?? this.nameAr,
        nameEn: nameEn ?? this.nameEn,
        image: image ?? this.image,
        points: points ?? this.points,
        description: description ?? this.description,
        unitId: unitId ?? this.unitId,
        categoryId: categoryId ?? this.categoryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        unitNameAr: unitNameAr ?? this.unitNameAr,
        unitNameEn: unitNameEn ?? this.unitNameEn,
        categoryNameAr: categoryNameAr ?? this.categoryNameAr,
        categoryNameEn: categoryNameEn ?? this.categoryNameEn,
      );

  factory WasteItem.fromJson(Map<String, dynamic> json) => WasteItem(
        id: json["id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        image: json["image"],
        points: json["points"],
        description: json["description"],
        unitId: json["unit_id"],
        categoryId: json["category_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        unitNameAr: json["unit_name_ar"],
        unitNameEn: json["unit_name_en"],
        categoryNameAr: json["category_name_ar"],
        categoryNameEn: json["category_name_en"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
        "image": image,
        "points": points,
        "description": description,
        "unit_id": unitId,
        "category_id": categoryId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "unit_name_ar": unitNameAr,
        "unit_name_en": unitNameEn,
        "category_name_ar": categoryNameAr,
        "category_name_en": categoryNameEn,
      };
}
