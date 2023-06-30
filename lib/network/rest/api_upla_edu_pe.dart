import 'package:dio/dio.dart';
import 'package:upla/constants.dart';
import 'dart:io';

import '../exception/resolve.dart';

class ApiUplaEduPeDio {
  static final Dio _dio = Dio();

  static void configureDio() {
    _dio.options.baseUrl = apiUplaEduPe;

    _dio.options.connectTimeout = 60000; // 1 minuto
    _dio.options.receiveTimeout = 58000;

    _dio.options.headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
    };
  }

  static Future<dynamic> obtenerWifi(String codigo,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.get(
        "/servicios/app-movil/obtenerwifi/$codigo",
      ),
    );
  }

  static Future<dynamic> progresoAcademico(String codigo,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.get(
        "/servicios/app-movil/progresoacademico/$codigo",
      ),
    );
  }

  static Future<dynamic> obtenerDatos(String codigo,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.get(
        "/servicios/app-movil/obtenerdatos/$codigo",
      ),
    );
  }

  static Future<dynamic> notificarPregunta(Map<String, dynamic> payload,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.post(
        "/servicios/sse/sendall",
        data: payload,
        cancelToken: cancelToken,
      ),
    );
  }
}
