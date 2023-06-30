import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:upla/constants.dart';

class Alert {
  BuildContext context;

  Alert(this.context);

  static Alert show(BuildContext context, String response,
      {Function()? callback}) {
    Alert alert = Alert(context);
    alert.showAlert(response, callback: callback);
    return alert;
  }

  static Alert confirm(BuildContext context, String response,
      {Function()? aceptar, Function()? cancelar}) {
    Alert alert = Alert(context);
    alert.showConfirm(response, aceptar: aceptar, cancelar: cancelar);
    return alert;
  }

  void showAlert(String response, {Function()? callback}) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            title: Row(
              children: [
                SvgPicture.asset(
                  "assets/images/logo_only.svg",
                  height: 40,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'UPLA',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    response,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Aceptar',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: kPrimaryColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (callback != null) callback();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showConfirm(String response,
      {Function()? aceptar, Function()? cancelar}) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              SvgPicture.asset(
                "assets/images/logo_only.svg",
                height: 40,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'UPLA',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  response,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kPrimaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (aceptar != null) aceptar();
              },
              child: const Text(
                'Aceptar',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              child: const Text(
                'Cancelar',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: kPrimaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (cancelar != null) cancelar();
              },
            ),
          ],
        );
      },
    );
  }
}
