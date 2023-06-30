import 'package:dio/dio.dart';

class RestError {
  late DioErrorType type;
  late String message;

  RestError.Dio(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        type = error.type;
        message = "Se canceló la solicitud al servidor API";
        break;
      case DioErrorType.connectTimeout:
        type = error.type;
        message =
            "Se termino el tiempo de espera de conexión con el servidor API";
        break;
      case DioErrorType.receiveTimeout:
        type = error.type;
        message =
            "Tiempo de espera de recepción en conexión con el servidor API";
        break;
      case DioErrorType.response:
        type = error.type;
        message = _handleError(
          error.response?.statusCode,
          error.response?.data,
        );
        break;
      case DioErrorType.sendTimeout:
        type = error.type;
        message = "Enviar tiempo de espera en conexión con el servidor API";
        break;
      case DioErrorType.other:
        type = error.type;
        if (error.message.contains("SocketException")) {
          message = 'Sin internet';
          break;
        }
        message = "Ocurrió un error inesperado";
        break;
      default:
        type = DioErrorType.other;
        message = "Algo salió mal";
        break;
    }
  }

  RestError.String(String error) {
    type = DioErrorType.other;
    message = error;
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return error['message'] ?? "Algo en el cliente se esta enviando mal.";
      case 401:
        return "Unauthorized";
      case 403:
        return "Forbidden";
      case 404:
        return "Not Found";
      case 500:
        return error['message'] ?? "Servicio en mantenimiento.";
      case 502:
        return 'Bad gateway';
      default:
        return 'Huy! Algo salió mal';
    }
  }

  DioErrorType getType() {
    return type;
  }

  String getMessage() {
    return message;
  }
}
