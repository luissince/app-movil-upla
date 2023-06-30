import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upla/constants.dart';
import 'package:upla/model/version.dart';
import 'package:upla/network/exception/rest_error.dart';
import 'package:upla/ui/pages/home/home_screen.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/model/session.dart';
import 'package:upla/ui/components/activity_indicator.dart';
import 'package:upla/ui/components/rounded_button.dart';
import 'package:upla/ui/pages/login/login_screen.dart';
import 'package:upla/ui/pages/version/version_screen.dart';
import 'package:upla/ui/pages/welcome/welcome_screen.dart';

class ConnectionScreen extends StatefulWidget {
  static String id = "connection_page";

  const ConnectionScreen({Key? key}) : super(key: key);

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  AppProvider? appProvider;

  _ConnectionScreenState();

  bool isInit = false;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);

    Size size = MediaQuery.of(context).size;

    String string = "Offline";

    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: SizedBox(
          width: double.infinity,
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              /**
               * 
               */
              SafeArea(
                child: SingleChildScrollView(
                  child: isConnected
                      ? const Column(
                          children: [
                            ActivityIndicator(
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Restableciendo conexión...",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      : connectionWidget(string, size),
                ),
              ),

              /**
               * 
               */
              isConnected
                  ? const SizedBox()
                  : Positioned(
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: Column(
                          children: [
                            RoundedButton(
                              text: "Reintertar",
                              height: 50,
                              press: _reloadApp,
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget connectionWidget(String string, Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SvgPicture.asset(
              "assets/icons/wifi.svg",
              height: size.height * 0.30,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        /**
          * 
          */
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Text(
            // string == "Offline"
            // ? "Activa tus datos móviles o wifi":
            "!Ups! No tenés internet",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Text(
            "Lo sentimos al parecer no tenés conexión.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Text(
            string,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void _reloadApp() async {
    setState(() {
      isConnected = true;
    });

    dynamic response = await appProvider!.pingGoogle();

    if (response is Response) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      dynamic response = await appProvider!.versionApp();

      if (response is Map || response is String) {
        _appInitial(prefs);
        return;
      }

      PackageInfo packageInfo = await _getPackageInfo();

      response as Response;

      if (response.statusCode == 204) {
        _appInitial(prefs);
        return;
      }

      Version version = Version.fromJson(response.data);
      if (version.buildNumber == packageInfo.buildNumber) {
        _appInitial(prefs);
      } else {
        _navigateVersion();
      }
    }

    if (response is RestError) {
      setState(() {
        isConnected = false;
      });
    }
  }

  void _appInitial(SharedPreferences prefs) async {
    if (prefs.getString("token") != null) {
      appProvider!.isLoading = true;
      appProvider!.isSignout = false;

      Session session = Session();
      session.token = prefs.getString("token")!;
      session.docNumId = prefs.getString("docNumId")!;
      session.persPaterno = prefs.getString("persPaterno")!;
      session.persMaterno = prefs.getString("persMaterno")!;
      session.persNombre = prefs.getString("persNombre")!;
      session.usuario = prefs.getString("usuario")!;
      session.clave = prefs.getString("clave")!;
      appProvider!.session = session;

      bool token = await _validToken(session.token!);

      if (token) {
        _navigateHome();
      } else {
        Map<String, dynamic> payload = {
          "codigo": prefs.getString("usuario")!,
          "contraseña": prefs.getString("clave")!,
        };

        dynamic response = await appProvider!.login(payload);
        if (response is Response) {
          var user = response.data;

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();

          prefs.setString("token", user["token"]);
          prefs.setString("docNumId", user["docNumId"]);
          prefs.setString("persPaterno", user["persPaterno"]);
          prefs.setString("persMaterno", user["persMaterno"]);
          prefs.setString("persNombre", user["persNombre"]);
          prefs.setString("usuario", payload["codigo"]);
          prefs.setString("clave", payload["contraseña"]);

          appProvider!.isLoading = true;
          appProvider!.isSignout = false;

          Session session = Session();
          session.token = prefs.getString("token")!;
          session.docNumId = prefs.getString("docNumId")!;
          session.persPaterno = prefs.getString("persPaterno")!;
          session.persMaterno = prefs.getString("persMaterno")!;
          session.persNombre = prefs.getString("persNombre")!;
          session.usuario = prefs.getString("usuario")!;
          session.clave = prefs.getString("clave")!;
          appProvider!.session = session;

          _navigateHome();
        } else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();

          appProvider!.isLoading = false;
          appProvider!.isSignout = true;

          Session session = Session();
          appProvider!.session = session;

          _navigateLogin();
        }
      }
    } else {
      _navigateWelcome();
    }
  }

  Future<bool> _validToken(String token) async {
    dynamic response = await appProvider!.validarToken(token);

    if (response is Response) return true;

    return false;
  }

  Future<PackageInfo> _getPackageInfo() {
    return PackageInfo.fromPlatform();
  }

  void _navigateHome() {
    Navigator.pushReplacementNamed(
      context,
      HomeScreen.id,
    );
  }

  void _navigateWelcome() {
    Navigator.pushReplacementNamed(
      context,
      WelcomeScreen.id,
    );
  }

  void _navigateLogin() {
    Navigator.pushReplacementNamed(
      context,
      LoginScreen.id,
    );
  }

  void _navigateVersion() {
    Navigator.pushReplacementNamed(
      context,
      VersionScreen.id,
    );
  }
}
