import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:upla/enums/connectivity_status.dart';

class ConnectivityService {
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

  // ConnectivityService() {
  //   Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
  //     ConnectivityStatus connectivityStatus = _getStatusFromResult(result);
  //     connectionStatusController.add(connectivityStatus);
  //   });
  // }

  // ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
  //   switch (result) {
  //     case ConnectivityResult.mobile:
  //       return ConnectivityStatus.Celular;
  //     case ConnectivityResult.mobile:
  //       return ConnectivityStatus.WiFi;
  //     case ConnectivityResult.none:
  //       return ConnectivityStatus.Offline;
  //     default:
  //       return ConnectivityStatus.Offline;
  //   }
  // }
}
