class ProductQuantityModel {
  final int? productId;
  final int? quantity;

  ProductQuantityModel({this.productId, this.quantity});

  ProductQuantityModel copyWith({int? productId, int? quantity}) =>
      ProductQuantityModel(
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
      );

  factory ProductQuantityModel.fromJson(Map<String, dynamic> json) =>
      ProductQuantityModel(
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "quantity": quantity,
  };
}
