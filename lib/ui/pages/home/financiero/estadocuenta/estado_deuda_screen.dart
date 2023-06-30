import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/network/exception/rest_error.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/components/activity_indicator.dart';
import 'package:upla/ui/pages/home/widget/annotate_region_widget.dart';
import 'package:upla/ui/pages/home/widget/app_bar_ca_widget.dart';

import '../../../../../constants.dart';
import '../../../../../model/deuda.dart';

class EstadoDeudaScreen extends StatefulWidget {
  static String id = "estado_deuda_page";

  const EstadoDeudaScreen({Key? key}) : super(key: key);

  @override
  State<EstadoDeudaScreen> createState() => _EstadoDeudaScreenState();
}

class _EstadoDeudaScreenState extends State<EstadoDeudaScreen> {
  AppProvider? appProvider;

  bool vista = true;
  bool cargando = false;
  bool respondeOk = false;
  double sumaTotal = 0;
  String mensaje = "";
  List<Deuda> listDeudas = [];

  CancelToken cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _cargarCuotasPensiones();
    });
  }

  @override
  void dispose() {
    cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 248, 250, 1),
      appBar: AppBarCaWidget(title: "Deudas").build(context),
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
            _contenedorSubTitulo(),
            _contenedorDetalle(size),
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
            "Puede consultar el estado de su deuda.",
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }

  Widget _contenedorSubTitulo() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Flexible(
              child: Text(
                "PENSIÓN ACADÉMICA",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "S/",
                      style: TextStyle(
                          color: Color.fromRGBO(41, 45, 67, 1),
                          fontSize: 26,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      sumaTotal.toStringAsFixed(2),
                      style: const TextStyle(
                          color: Color.fromRGBO(41, 45, 67, 1),
                          fontSize: 23,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const Text(
                  "MONTO TOTAL",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(41, 45, 67, 1),
                      fontSize: 11,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _contenedorDetalle(Size size) {
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

    if (cargando) {
      return const Expanded(
        child: SizedBox.expand(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ActivityIndicator(
                  color: kPrimaryColor,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Cargando Información...",
                  style: TextStyle(
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

    if (!respondeOk) {
      return Expanded(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.warning,
                  color: Color.fromRGBO(254, 1, 3, 1),
                  size: 37,
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

    if (listDeudas.isEmpty) {
      return Expanded(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/deudas.png",
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
      child: SizedBox(
        width: size.width,
        child: Container(
          margin: const EdgeInsets.only(
            top: 10,
          ),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
                children: listDeudas.map((Deuda deuda) {
              return Container(
                margin: EdgeInsets.only(
                  bottom: deuda.key == listDeudas.length ? 0 : 10,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: deuda.key == listDeudas.length ? 0 : 1,
                      color: deuda.key == listDeudas.length
                          ? Colors.white
                          : const Color.fromARGB(255, 245, 245, 245),
                    ),
                  ),
                ),
                child: Column(children: [
                  _contenedorItem(deuda),
                  SizedBox(
                    height: deuda.key == listDeudas.length ? 0 : 10,
                  ),
                ]),
              );
            }).toList()),
          ),
        ),
      ),
    );
  }

  Widget _contenedorItem(Deuda deuda) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.info,
          size: 32,
          color: Color.fromRGBO(252, 127, 167, 1),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                deuda.descripcion,
                style: const TextStyle(
                  color: Color.fromRGBO(42, 49, 73, 1),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                deuda.fecVenc,
                style: const TextStyle(
                  color: Color.fromRGBO(42, 49, 73, 0.5),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "S/ ${deuda.importe}",
              style: const TextStyle(
                color: Color.fromRGBO(42, 49, 73, 1),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "S/ ${deuda.mora}",
              style: const TextStyle(
                color: Color.fromRGBO(253, 3, 6, 1),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "S/ ${deuda.subtotal}",
              style: const TextStyle(
                color: Color.fromRGBO(42, 49, 73, 1),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<void> _cargarCuotasPensiones() async {
    if (cargando) {
      return;
    }

    setState(() {
      vista = false;
      cargando = true;
      respondeOk = false;
    });

    Map<String, dynamic> payload = {
      "codigo": appProvider!.session.docNumId,
    };

    dynamic response = await appProvider!.cuotasPensiones(
      payload,
      cancelToken: cancelToken,
    );

    if (response is Response) {
      List<dynamic> list = response.data;

      if (list.isEmpty) {
        setState(() {
          listDeudas = [];
          cargando = false;
          respondeOk = true;
          mensaje = "No tiene cuotas o esta al día.";
        });
      } else {
        int count = 0;
        sumaTotal = 0;
        List<Deuda> newListPagos = [];

        for (var u in list) {
          count++;
          sumaTotal += u["subtotal"];
          newListPagos.add(
            Deuda(
              count,
              u["descripcion"],
              u["fecVenc"],
              u["tm"],
              u["importe"],
              u["mora"],
              u["subtotal"],
              u["obs"],
            ),
          );
        }

        setState(() {
          listDeudas = newListPagos;
          cargando = false;
          respondeOk = true;
          mensaje = "";
        });
      }
    }

    if (response is RestError) {
      if (response.type == DioErrorType.cancel) return;

      setState(() {
        listDeudas = [];
        cargando = false;
        respondeOk = false;
        mensaje = response.message;
      });
    }
  }
}
