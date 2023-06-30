import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/constants.dart';
import 'package:upla/model/wifi.dart';
import 'package:upla/network/exception/rest_error.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/components/activity_indicator.dart';
import 'package:upla/ui/pages/home/widget/annotate_region_widget.dart';
import 'package:upla/ui/pages/home/widget/app_bar_ca_widget.dart';

class ZonaWifiScreen extends StatefulWidget {
  static String id = "zona_wifi_page";

  const ZonaWifiScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ZonaWifiScreen> createState() => _ZonaWifiState();
}

class _ZonaWifiState extends State<ZonaWifiScreen> {
  AppProvider? appProvider;

  bool vista = true;
  bool cargando = false;
  bool respondeOk = false;
  String mensaje = "";
  late Wifi wifi;

  CancelToken cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _cargandoDatosWifi();
    });
  }

  @override
  void dispose() async {
    super.dispose();
    cancelToken.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBarCaWidget(title: "Zona Wifi").build(context),
      body: AnnotateRegionWidget(children: _main(size)).build(context),
    );
  }

  Widget _main(Size size) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          children: [
            _contenedorTitulo(size),
            _contenedorDetalle(),
          ],
        ),
      ),
    );
  }

  Widget _contenedorTitulo(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            CupertinoIcons.lightbulb,
            color: Color(0xffffd42f),
            size: 36,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "¡Hola!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "${appProvider!.session.persNombre}, ${appProvider!.session.persPaterno} ${appProvider!.session.persMaterno}",
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "Puede consultar las credenciales de su WIFI de la universidad.",
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }

  Widget _contenedorDetalle() {
    if (vista) {
      return const Expanded(
        child: SizedBox.expand(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActivityIndicator(
                  color: kPrimaryColor,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    if (cargando) {
      return const Expanded(
        child: SizedBox.expand(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActivityIndicator(
                  color: kPrimaryColor,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Cargando información...",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    if (!respondeOk) {
      return Expanded(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/nowifi.png",
                  width: 48,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  textAlign: TextAlign.center,
                  mensaje,
                  style: const TextStyle(
                    color: kDartLightColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Expanded(
        child: SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Usuario:",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SelectableText(
              wifi.codigo,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Color(0xfff1f1f1),
                ),
              )),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Contraseña:",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SelectableText(
              wifi.password,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> _cargandoDatosWifi() async {
    if (cargando) {
      return;
    }

    setState(() {
      vista = false;
      cargando = true;
      respondeOk = false;
    });

    dynamic response = await appProvider!.obtenerWifi(
      cancelToken: cancelToken,
    );

    if (response is Response) {
      setState(() {
        cargando = false;
        respondeOk = true;
        mensaje = "";
        wifi = Wifi.fromJson(response.data);
      });
    }

    if (response is RestError) {
      if (response.type == DioErrorType.cancel) return;

      setState(() {
        cargando = false;
        respondeOk = false;
        mensaje = response.message;
      });
    }
  }
}
