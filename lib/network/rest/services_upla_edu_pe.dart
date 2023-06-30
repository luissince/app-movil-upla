import 'package:dio/dio.dart';
import 'package:upla/constants.dart';
import 'dart:io';

import '../exception/resolve.dart';

class ServicesUplaEduPeDio {
  static final Dio _dio = Dio();

  static void configureDio() {
    _dio.options.baseUrl = apiUrl;

    _dio.options.connectTimeout = 60000; // 1 minuto
    _dio.options.receiveTimeout = 58000;

    _dio.options.headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
    };
  }

  static Future<dynamic> versionApp({CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.get(
        "/Aplicacion/versionApp",
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<dynamic> informacionFicha(String codEstudiante, String token,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.post(
        "/estudiante/datosFicha",
        data: {
          "codigo": codEstudiante,
        },
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<dynamic> login(Map<String, dynamic> payload,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.post(
        "/Login",
        data: payload,
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<dynamic> estudianteConstancia(
      String codEstudiante, String token,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.post(
        "/estudiante/consNota",
        data: {
          "codigo": codEstudiante,
        },
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<dynamic> estudianteMallaCurricular(
      String codEstudiante, String token,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.post(
        "/estudiante/mallaCurricular",
        data: {
          "codigo": codEstudiante,
        },
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<dynamic> estudianteProgresoCurricular(
      String codEstudiante, String token,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(_dio.post(
      "/estudiante/progresoCurricular",
      data: {
        "codigo": codEstudiante,
      },
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      ),
      cancelToken: cancelToken,
    ));
  }

  static Future<dynamic> mostrarFacultad(String codEstudiante, String token,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.get(
        "/MostrarFacultad/$codEstudiante",
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<dynamic> validarToken(String token,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.get(
        "/Aplicacion/validarToken",
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<dynamic> estudianteHorario(String codEstudiante, String token,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.post(
        "/estudiante/Horario",
        data: {
          "codigo": codEstudiante,
        },
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<dynamic> estudianteHorarioDetalle(
      String codEstudiante, String token,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.post(
        "/estudiante/horarioDetalle",
        data: {
          "codigo": codEstudiante,
        },
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<dynamic> publicaciones(String token,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.get(
        "/Aplicacion/publicaciones",
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<dynamic> wifi(String codEstudiante, String token,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.post(
        "/estudiante/Wifi",
        data: {
          "codigo": codEstudiante,
        },
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<dynamic> cuotasPensiones(
      Map<String, dynamic> payload, String token,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.post(
        "/cuotasPen",
        data: payload,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<dynamic> pagosRealizados(
      Map<String, dynamic> payload, String token,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.post(
        "/estudiante/ultimosPagos",
        data: payload,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<dynamic> estudianteComprobarEncuesta(
      String codEstudiante, String token,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.get(
        "/ComprobarEncuesta/$codEstudiante",
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<dynamic> estudianteRegistrarEncuesta(
      Object payload, String token,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.post(
        "/registraEncuensta",
        data: payload,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<dynamic> estudianteListaPreguntaEncuesta(
      String codEstudiante, String token,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.get(
        "/estudiante/listarPreguntaEnc/$codEstudiante",
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<dynamic> listarConsultasPorIdEst(
      Map<String, dynamic> payload, String token,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.post(
        "/Soporte/listarConsultasPorIdEst",
        data: payload,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<dynamic> obtenerConsultaPorIdConsulta(
      String idConsulta, String token,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.get(
        "/Soporte/obtenerConsultaPorIdConsulta/$idConsulta",
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<dynamic> obtenerRespuestasPorIdConsulta(
      Map<String, dynamic> payload, String token,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.post(
        "/Soporte/ObtenerRespuestasPorIdConsulta",
        data: payload,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<dynamic> registrarConsulta(
      Map<String, dynamic> payload, String token,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.post(
        "/Soporte/registrarConsulta",
        data: payload,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<dynamic> listarFrecuentes(
      Map<String, dynamic> payload, String token,
      {CancelToken? cancelToken}) async {
    return await Resolve.create(
      _dio.post(
        "/Soporte/listarFrecuentesMovil",
        data: payload,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<dynamic> pingGoogle({CancelToken? cancelToken}) async {
    Dio dio = Dio();
    dio.options.baseUrl = urlGoogle;

    dio.options.connectTimeout = 60000; // 1 minuto
    dio.options.receiveTimeout = 58000;

    dio.options.headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
    };

    return await Resolve.create(dio.get(
      "",
      cancelToken: cancelToken,
    ));
  }
}
