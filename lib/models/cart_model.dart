import 'dart:convert';

import 'package:fake_store_app/models/product_quantity_model.dart';

class CartModel {
  final int? id;
  final int? userId;
  final DateTime? date;
  final List<ProductQuantityModel>? products;
  final int? v;

  CartModel({this.id, this.userId, this.date, this.products, this.v});

  CartModel copyWith({
    int? id,
    int? userId,
    DateTime? date,
    List<ProductQuantityModel>? products,
    int? v,
  }) => CartModel(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    date: date ?? this.date,
    products: products ?? this.products,
    v: v ?? this.v,
  );

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json["id"],
    userId: json["userId"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    products:
        json["products"] == null
            ? []
            : List<ProductQuantityModel>.from(
              json["products"]!.map((x) => ProductQuantityModel.fromJson(x)),
            ),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "date": date?.toIso8601String(),
    "products":
        products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
    "__v": v,
  };

  @override
  String toString() {
    final prettyJson = JsonEncoder.withIndent('  ').convert(toJson());
    return prettyJson;
  }
}
