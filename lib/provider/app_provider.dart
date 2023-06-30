import 'dart:async';
import 'dart:io';

// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:upla/enums/connectivity_status.dart';
import 'package:upla/model/encuesta_pregunta_detalle.dart';
import 'package:upla/model/session.dart';
import 'package:upla/network/rest/api_upla_edu_pe.dart';
import 'package:upla/network/rest/services_upla_edu_pe.dart';
import 'package:upla/ui/components/notifications_app.dart';

class AppProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isSignout = true;
  Session session = Session();

  Map<String, dynamic> payload = {};

  Map<String, dynamic> response = {};

  List<EncuestaPreguntaDetalle> listaEncuestaPregunta = [];

  String idConsulta = "";

  String token = "";

  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

  late FirebaseMessaging _firebaseMessaging;

  late final NotificationService notificationService;

  AppProvider() {
    // Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    //   ConnectivityStatus connectivityStatus = _getStatusFromResult(result);
    //   print(connectivityStatus);
    //   connectionStatusController.add(connectivityStatus);
    // });

    notificationService = NotificationService();
    notificationService.initializePlatformNotifications();

    if (Platform.isAndroid) {
      _firebaseMessaging = FirebaseMessaging.instance;

      _firebaseMessaging.requestPermission();
      _firebaseMessaging
          .getToken()
          .then((tokenFirebase) => token = tokenFirebase!);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        await notificationService.showLocalNotification(
          id: 0,
          title: message.notification?.title ?? "",
          body: message.notification?.body ?? "",
          payload: "Acabas de iniciar sesión!",
        );
      });
    }
  }

  // ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
  //   switch (result) {
  //     case ConnectivityResult.mobile:
  //       return ConnectivityStatus.Celular;
  //     case ConnectivityResult.wifi:
  //       return ConnectivityStatus.WiFi;
  //     case ConnectivityResult.none:
  //       return ConnectivityStatus.Offline;
  //     default:
  //       return ConnectivityStatus.Offline;
  //   }
  // }

  Future<dynamic> login(Map<String, dynamic> data,
      {CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.login(data, cancelToken: cancelToken);
  }

  Future<dynamic> versionApp({CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.versionApp(cancelToken: cancelToken);
  }

  Future<dynamic> informacionFicha({CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.informacionFicha(
        session.docNumId!, session.token!,
        cancelToken: cancelToken);
  }

  Future<dynamic> estudianteConstancia({CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.estudianteConstancia(
        session.docNumId!, session.token!,
        cancelToken: cancelToken);
  }

  Future<dynamic> mostrarFacultad({CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.mostrarFacultad(
        session.docNumId!, session.token!,
        cancelToken: cancelToken);
  }

  Future<dynamic> validarToken(String token, {CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.validarToken(token,
        cancelToken: cancelToken);
  }

  Future<dynamic> estudianteHorario({CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.estudianteHorario(
        session.docNumId!, session.token!,
        cancelToken: cancelToken);
  }

  Future<dynamic> estudianteHorarioDetalle({CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.estudianteHorarioDetalle(
        session.docNumId!, session.token!,
        cancelToken: cancelToken);
  }

  Future<dynamic> estudianteMallaCurricular({CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.estudianteMallaCurricular(
        session.docNumId!, session.token!,
        cancelToken: cancelToken);
  }

  Future<dynamic> estudianteProgresoCurricular(
      {CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.estudianteProgresoCurricular(
        session.docNumId!, session.token!,
        cancelToken: cancelToken);
  }

  Future<dynamic> publicaciones({CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.publicaciones(session.token!,
        cancelToken: cancelToken);
  }

  Future<dynamic> wifi({CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.wifi(session.docNumId!, session.token!,
        cancelToken: cancelToken);
  }

  Future<dynamic> cuotasPensiones(Map<String, dynamic> data,
      {CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.cuotasPensiones(data, session.token!,
        cancelToken: cancelToken);
  }

  Future<dynamic> pagosRealizados(Map<String, dynamic> data,
      {CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.pagosRealizados(data, session.token!,
        cancelToken: cancelToken);
  }

  Future<dynamic> estudianteComprobarEncuesta(
      {CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.estudianteComprobarEncuesta(
        session.docNumId!, session.token!,
        cancelToken: cancelToken);
  }

  Future<dynamic> estudianteListaPreguntaEncuesta(
      {CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.estudianteListaPreguntaEncuesta(
        session.docNumId!, session.token!,
        cancelToken: cancelToken);
  }

  Future<dynamic> estudianteRegistrarEncuenta(Object data,
      {CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.estudianteRegistrarEncuesta(
        data, session.token!,
        cancelToken: cancelToken);
  }

  Future<dynamic> listarConsultasPorIdEst(Map<String, dynamic> data,
      {CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.listarConsultasPorIdEst(
        data, session.token!,
        cancelToken: cancelToken);
  }

  Future<dynamic> obtenerConsultaPorIdConsulta(String idConsulta,
      {CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.obtenerConsultaPorIdConsulta(
        idConsulta, session.token!,
        cancelToken: cancelToken);
  }

  Future<dynamic> obtenerRespuestasPorIdConsulta(Map<String, dynamic> data,
      {CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.obtenerRespuestasPorIdConsulta(
        data, session.token!,
        cancelToken: cancelToken);
  }

  Future<dynamic> registrarConsulta(Map<String, dynamic> data,
      {CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.registrarConsulta(data, session.token!,
        cancelToken: cancelToken);
  }

  Future<dynamic> listarFrecuentes(Map<String, dynamic> data,
      {CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.listarFrecuentes(data, session.token!,
        cancelToken: cancelToken);
  }

  Future<dynamic> pingGoogle({CancelToken? cancelToken}) async {
    return await ServicesUplaEduPeDio.pingGoogle(cancelToken: cancelToken);
  }

  Future<dynamic> obtenerWifi({CancelToken? cancelToken}) async {
    return await ApiUplaEduPeDio.obtenerWifi(session.docNumId!,
        cancelToken: cancelToken);
  }

  Future<dynamic> progresoAcademico({CancelToken? cancelToken}) async {
    return await ApiUplaEduPeDio.progresoAcademico(session.docNumId!,
        cancelToken: cancelToken);
  }

  Future<dynamic> obtenerDatos({CancelToken? cancelToken}) async {
    return await ApiUplaEduPeDio.obtenerDatos(session.docNumId!,
        cancelToken: cancelToken);
  }

  Future<dynamic> notificarPregunta(Map<String, dynamic> data,
      {CancelToken? cancelToken}) async {
    return await ApiUplaEduPeDio.notificarPregunta(data,
        cancelToken: cancelToken);
  }
}
