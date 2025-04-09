import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fake_store_app/util/failures.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  HttpHelper();

  static Future<Either<Failure, http.Response>> get(String url) async {
    return _request(() => http.get(Uri.parse(url)));
  }

  static Future<Either<Failure, http.Response>> post<T>(
    String url,
    Map<String, dynamic> body,
  ) async {
    return _request(
      () => http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      ),
    );
  }

  static Future<Either<Failure, http.Response>> _request<T>(
    Future<http.Response> Function() request,
  ) async {
    try {
      final response = await request();

      switch (response.statusCode) {
        case 200:
          return Right(response);
        case 400:
          return Left(BadRequestFailure(response.body));
        case 500:
          return Left(ServerFailure(response.body));
        default:
          return throw response;
      }
    } on SocketException catch (e) {
      return Left(ConnectionFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
