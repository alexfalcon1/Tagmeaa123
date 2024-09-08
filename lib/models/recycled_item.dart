
class RecycledItem {
  int? categoryId;
  String? categoryNameAr;
  String? categoryNameEn;
  String? itemNameAr;
  String? itemNameEn;
  String? image;
  String? unitNameAr;
  String? unitNameEn;
  int? cartId;
  int? itemId;
  double? quantity;
  double? points;
  double? totalMoney;
  double? totalPoints;
  String? createdAt;
  String? modifiedAt;

  RecycledItem(
      {this.categoryId,
        this.categoryNameAr,
        this.categoryNameEn,
        this.itemNameAr,
        this.itemNameEn,
        this.image,
        this.unitNameAr,
        this.unitNameEn,
        this.cartId,
        this.itemId,
        this.quantity,
        this.points,
        this.totalMoney,
        this.totalPoints,
        this.createdAt,
        this.modifiedAt});

  RecycledItem.fromJson(Map<String, dynamic> json) {
    categoryId = int.parse(json['category_id'].toString()) ;
    categoryNameAr = json['category_name_ar'];
    categoryNameEn = json['category_name_en'];
    itemNameAr = json['item_name_ar'];
    itemNameEn = json['item_name_en'];
    image = json['image'];
    unitNameAr = json['unit_name_ar'];
    unitNameEn = json['unit_name_en'];
    cartId = int.parse(json['cart_id'].toString());
    itemId = int.parse(json['item_id'].toString());
    quantity = double.parse(json['quantity'].toString());
    points = double.parse(json['points'].toString());
    totalMoney = double.parse(json['total_money'].toString());
    totalPoints = double.parse(json['total_points'].toString());
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_name_ar'] = categoryNameAr;
    data['category_name_en'] = categoryNameEn;
    data['item_name_ar'] = itemNameAr;
    data['item_name_en'] = itemNameEn;
    data['image'] = image;
    data['unit_name_ar'] = unitNameAr;
    data['unit_name_en'] = unitNameEn;
    data['cart_id'] = cartId;
    data['item_id'] = itemId;
    data['quantity'] = quantity;
    data['points'] = points;
    data['total_money'] = totalMoney;
    data['total_points'] = totalPoints;
    data['created_at'] = createdAt;
    data['modified_at'] = modifiedAt;
    return data;
  }

  @override
  String toString() {
    return
        "\n{cart_id : $cartId, "
        "category_id:$categoryId, "
        "category_name:$categoryNameAr, "
        "item_id:$itemId, item_name:$itemNameAr "
        "-> money: $totalMoney = $totalPoints points}\n";
  }
}
