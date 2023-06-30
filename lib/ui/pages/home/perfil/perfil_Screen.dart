
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/components/alert.dart';
import 'package:upla/ui/pages/home/perfil/centroayuda/centro_ayuda_screen.dart';
import 'package:upla/ui/pages/home/perfil/datospersonales/datos_personales_screen.dart';
import 'package:upla/ui/pages/home/perfil/documentos/documentos_screen.dart';
import 'package:upla/ui/pages/home/perfil/generarqr/generar_qr_screen.dart';
import 'package:upla/ui/pages/home/perfil/seguridad/seguridad_screen.dart';
import 'package:upla/ui/pages/home/perfil/zonawifi/zona_wifi_screen.dart';
import 'package:upla/ui/pages/home/widget/button_home.dart';
import 'package:upla/ui/pages/home/widget/headboard_home.dart';
import 'package:upla/ui/pages/home/widget/title_home.dart';
import 'package:upla/ui/pages/login/login_screen.dart';

import '../../../../model/session.dart';
import '../widget/background_home.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({Key? key}) : super(key: key);

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen>
    with AutomaticKeepAliveClientMixin {
  AppProvider? appProvider;

  bool loading = false;
  bool responseOk = false;
  String message = "";

  String codigo = "";
  String nombre = "";
  String apPaterno = "";
  String apMaterno = "";
  String edad = "";
  String fcNacimiento = "";
  String telefono = "";
  String celular = "";
  String email = "";

  bool loadingWifi = false;
  bool responseOkWifi = false;
  String messageWifi = "";


  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size size = MediaQuery.of(context).size;

    appProvider = Provider.of<AppProvider>(context);

    return BackgroundHome(
      onRefresh: () async {
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
   
          HeadBoardHome(
            size: size,
            docNumId: appProvider!.session.docNumId!,
            bottom: 10,
          ),


          TitleHome(
            title: "Mi Cuenta",
            subTitle:
                "${appProvider!.session.persNombre}, ${appProvider!.session.persPaterno} ${appProvider!.session.persMaterno}",
            content: '',
          ),
     
          ButtonHome(
            onPressed: () {
               Navigator.pushNamed(
                context,
                DatosPersonalesScreen.id,
              );
            },
            title: "Datos Personales",
            icon: CupertinoIcons.person_crop_circle_fill_badge_exclam,
          ),

          ButtonHome(
            onPressed: () {
               Navigator.pushNamed(
                context,
                SeguridadScreen.id,
              );
            },
            title: "Seguridad",
            icon: CupertinoIcons.exclamationmark_shield,
          ),

          ButtonHome(
            onPressed: () {
               Navigator.pushNamed(
                context,
                DocumentosScreen.id,
              );
            },
            title: "Documentos",
            icon: CupertinoIcons.doc,
          ),

          ButtonHome(
            onPressed: () {
              Navigator.pushNamed(
                context,
                CentroAyudaScreen.id,
              );
            },
            title: "Centro de ayuda",
            icon: CupertinoIcons.question_circle,
          ),

          ButtonHome(
            onPressed: (){
               Navigator.pushNamed(
                context,
                ZonaWifiScreen.id,
              );
            },
            title: "Zona WiFi UPLA",
            icon: Icons.wifi,
          ),

          ButtonHome(
            onPressed: (){
               Navigator.pushNamed(
                context,
                GenerarQrScreen.id,
              );
            },
            title: "Identificación de ingreso QR",
            icon: Icons.qr_code,
          ),

          ButtonHome(
            onPressed: closeSession,
            title: "Cerrar Sesión",
            icon: Icons.power_settings_new,
          ),
        ],
      ),
    );
  }

  void closeSession() async {
    Alert.confirm(
      context,
      "¿Está seguro de cerrar sesión?",
      aceptar: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();

        appProvider!.isLoading = false;
        appProvider!.isSignout = true;

        Session session = Session();
        appProvider!.session = session;

        _navigateLogin();
      },
    );
  }

  void _navigateLogin() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      LoginScreen.id,
      (Route<dynamic> route) => false,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
