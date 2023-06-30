import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:upla/model/version.dart';
import 'package:upla/model/session.dart';
import 'package:upla/network/exception/rest_error.dart';
import 'package:upla/ui/pages/home/home_screen.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/components/activity_indicator.dart';
import 'package:upla/ui/pages/conection/connection_screen.dart';
import 'package:upla/ui/pages/login/login_screen.dart';
import 'package:upla/ui/pages/version/version_screen.dart';
import 'package:upla/ui/pages/welcome/welcome_screen.dart';

import '../../../constants.dart';

class SplashScreen extends StatefulWidget {
  static String id = "splash_page";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppProvider? appProvider;

  _SplashScreenState();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (prefs.getString("token") != null) {
          _initLoadApp(prefs);
        } else {
          _navigateWelcome();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /**
               * 
               */
              SvgPicture.asset(
                "assets/images/logo_only.svg",
                height: 160,
              ),
              /**
               * 
               */
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "U",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 34),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  Text(
                    "P",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 34),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  Text(
                    "L",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 34),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  Text(
                    "A",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 34),
                  ),
                ],
              ),
              /**
               * 
               */
              const Text(
                "UNIVERSIDAD PERUANA LOS ANDES",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 7,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              FutureBuilder(
                future: _getPackageInfo(),
                builder: (BuildContext context,
                    AsyncSnapshot<PackageInfo> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text(
                        "V 0.0.1",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      );
                    }

                    final data = snapshot.data!;
                    return Text(
                      data.version,
                      style: const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                      ),
                    );
                  }

                  return const Text(
                    "Cargando versión...",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  );
                },
              ),
              /**
                * 
                */
              const SizedBox(
                height: 10,
              ),
              const ActivityIndicator(
                size: 36,
                color: Color.fromRGBO(0, 125, 188, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _initLoadApp(SharedPreferences prefs) async {
    dynamic response = await appProvider!.versionApp();

    if (response is Response) {
      PackageInfo packageInfo = await _getPackageInfo();

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
      _navigateConnection();
      return;
    }
  }

  void _appInitial(SharedPreferences prefs) async {
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

  void _navigateConnection() {
    Navigator.pushReplacementNamed(
      context,
      ConnectionScreen.id,
      arguments: {
        "type": "noconnection",
      },
    );
  }
}
