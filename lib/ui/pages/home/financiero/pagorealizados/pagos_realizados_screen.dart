import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/model/pago.dart';
import 'package:upla/network/exception/rest_error.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/components/activity_indicator.dart';
import 'package:upla/ui/pages/home/widget/annotate_region_widget.dart';
import 'package:upla/ui/pages/home/widget/app_bar_ca_widget.dart';

import '../../../../../constants.dart';

class PagosRealizadosScreen extends StatefulWidget {
  static String id = "pagos_realizados_page";

  const PagosRealizadosScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PagosRealizadosScreen> createState() => _PagosRealizadosScreenState();
}

class _PagosRealizadosScreenState extends State<PagosRealizadosScreen> {
  AppProvider? appProvider;

  bool vista = true;
  bool cargando = false;
  bool respondeOk = false;
  String mensaje = "";
  List<Pago> listPagos = [];

  CancelToken cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _cargandoUltimosPagos();
    });
  }

  @override
  void dispose() {
    super.dispose();
    cancelToken.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBarCaWidget(title: "Pagos Realizados").build(context),
      body: AnnotateRegionWidget(children: _main(size)).build(context),
    );
  }

  Widget _main(Size size) {
    return RefreshIndicator(
      onRefresh: () async {
        _cargandoUltimosPagos();
      },
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          children: [
            _contenedorTitulo(size),
            _contendorUltimosPagos(size),
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
            "Puede consultar todos los pagos realizados hasta el momento.",
            style: TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }

  Widget _contendorUltimosPagos(Size size) {
    if (vista) {
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

    if (listPagos.isEmpty) {
      return Expanded(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/realizados.png",
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
                children: listPagos.map((Pago pago) {
              return Container(
                margin: EdgeInsets.only(
                  bottom: pago.key == listPagos.length ? 0 : 10,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: pago.key == listPagos.length ? 0 : 1,
                      color: pago.key == listPagos.length
                          ? Colors.white
                          : const Color.fromARGB(255, 245, 245, 245),
                    ),
                  ),
                ),
                child: Column(children: [
                  _contenedorItem(pago),
                  SizedBox(
                    height: pago.key == listPagos.length ? 0 : 10,
                  ),
                ]),
              );
            }).toList()),
          ),
        ),
      ),
    );
  }

  Widget _contenedorItem(Pago pago) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.payment,
          size: 32,
          color: Color.fromRGBO(217, 29, 88, 1),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pago.desoper,
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
                pago.periodo,
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
                pago.concepto,
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
                pago.fecha,
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
              pago.comprobante,
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
              pago.lugarOp,
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
              "${pago.moneda} ${pago.importe.toStringAsFixed(2)}",
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

  Future<void> _cargandoUltimosPagos() async {
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

    dynamic response = await appProvider!.pagosRealizados(
      payload,
      cancelToken: cancelToken,
    );

    if (response is Response) {
      List<dynamic> list = response.data;

      if (list.isEmpty) {
        setState(() {
          listPagos = [];
          cargando = false;
          respondeOk = true;
          mensaje = "No hay Pagos para Mostrar.";
        });
      } else {
        int count = 0;
        List<Pago> newListPagos = [];
        for (var item in list) {
          count++;
          newListPagos.add(
            Pago(
                count,
                item["desoper"],
                item["item"],
                item["fecha"],
                item["periodo"],
                item["concepto"],
                item["moneda"],
                item["importe"],
                item["obs"],
                item["comprobante"],
                item["lugarOp"]),
          );
        }

        setState(() {
          listPagos = newListPagos;
          cargando = false;
          respondeOk = true;
          mensaje = "";
        });
      }
    }

    if (response is RestError) {
      if (response.type == DioErrorType.cancel) return;

      setState(() {
        listPagos = [];
        cargando = false;
        respondeOk = false;
        mensaje = response.message;
      });
    }
  }
}
