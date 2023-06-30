import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upla/ui/pages/home/home_screen.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/components/alert.dart';
import 'package:upla/ui/components/already_have_an_account_acheck.dart';
import 'package:upla/ui/components/rounded_button.dart';
import 'package:upla/ui/pages/login/login_screen.dart';
import 'package:upla/ui/pages/welcome/welcome_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/session.dart';

class VersionScreen extends StatefulWidget {
  static String id = "version_page";

  const VersionScreen({Key? key}) : super(key: key);

  @override
  State<VersionScreen> createState() => _VersionScreenState();
}

class _VersionScreenState extends State<VersionScreen> {
  AppProvider? appProvider;

  _VersionScreenState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    appProvider = Provider.of<AppProvider>(context);

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/clock.svg",
                        height: size.height * 0.30,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                        ),
                        child: Text(
                          "Tiempo de Actualizar!",
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
                          "Agregamos muchas funciones nuevas y solucionamos algunos errores para que su experiencia sea lo más fluida posible.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              /**
               * 
               */
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      RoundedButton(
                        text: "ACTUALIZAR",
                        height: 50,
                        press: () async {
                          _launchURL();
                        },
                      ),
                     const SizedBox(
                        height: 10,
                      ),
                      AlreadyHaveAnAccountCheck(
                        text: "POR AHORO NO",
                        press: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          _appInitial(prefs);
                        },
                      ),
                    ],
                  ),
                ),
              ),

              /**
               * 
               */
            ],
          ),
        ),
      ),
    );
  }

  _launchURL() {
    final appId = Platform.isAndroid ? 'edu.pe.appupla' : 'edu.pe.appupla';
    if (Platform.isAndroid || Platform.isIOS) {
      try {
        final url = Uri.parse(
          Platform.isAndroid
              ? "market://details?id=$appId"
              : "https://apps.apple.com/app/id=$appId",
        );
        launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } on PlatformException catch (_) {
        Alert.show(context,
            "No tiene ninguna aplicación para abrir ${Platform.isAndroid ? "la tienda de Play Store" : "la tienda de App Store."}");
      }
    }
  }

  void _appInitial(SharedPreferences prefs) async {
    if (prefs.getString("token") != null) {
      bool token = await _validToken(prefs.getString("token")!);

      if (token) {
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

  void _navigateHome() {
    Navigator.pushReplacementNamed(
      context,
      HomeScreen.id,
    );
  }

  void _navigateLogin() {
    Navigator.pushReplacementNamed(
      context,
      LoginScreen.id,
    );
  }

  void _navigateWelcome() {
    Navigator.pushReplacementNamed(
      context,
      WelcomeScreen.id,
    );
  }
}
