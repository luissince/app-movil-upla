import 'package:dio/dio.dart';
import 'package:upla/network/exception/rest_error.dart';

class Resolve {
  static Future<dynamic> create(value) async {
    try {
      final Response response = await value;
      return response;
    } on DioError catch (ex) {
      return RestError.Dio(ex);
    } on Exception {
      return RestError.String(
          "Algo salió mal, intente en un par de minutos.");
    }
  }
}
