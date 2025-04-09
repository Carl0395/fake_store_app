import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fake_store_app/models/cart_model.dart';
import 'package:fake_store_app/models/product_model.dart';
import 'package:fake_store_app/util/failures.dart';
import 'package:fake_store_app/util/http_helper.dart';
import 'package:fake_store_app/util/routes.dart';

class ProductsRepository {
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    final res = await HttpHelper.get(Routes.products);

    return res.fold((failure) => Left(failure), (data) {
      try {
        final List<dynamic> jsonData = json.decode(data.body);
        final List<ProductModel> products =
            jsonData.map((item) => ProductModel.fromJson(item)).toList();
        return Right(products);
      } catch (e) {
        return Left(ParsingFailure(e.toString()));
      }
    });
  }

  Future<Either<Failure, ProductModel>> createProduct(
    ProductModel product,
  ) async {
    final res = await HttpHelper.post(Routes.products, product.toJson());

    return res.fold((failure) => Left(failure), (data) {
      try {
        return Right(ProductModel.fromJson(json.decode(data.body)));
      } catch (e) {
        return Left(ParsingFailure(e.toString()));
      }
    });
  }

  Future<Either<Failure, List<CartModel>>> getCarts() async {
    final res = await HttpHelper.get(Routes.carts);

    return res.fold((failure) => Left(failure), (data) {
      try {
        final List<dynamic> jsonData = json.decode(data.body);
        final List<CartModel> carts =
            jsonData.map((item) => CartModel.fromJson(item)).toList();
        return Right(carts);
      } catch (e) {
        return Left(ParsingFailure(e.toString()));
      }
    });
  }
}
