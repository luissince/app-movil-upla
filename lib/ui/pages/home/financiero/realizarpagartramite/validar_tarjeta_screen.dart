import 'package:flutter/material.dart';
import 'package:upla/constants.dart';
import 'package:upla/ui/components/alert.dart';
import 'package:upla/ui/pages/home/financiero/realizarpagartramite/procesando_pago_tramite_screen.dart';

class ValidarTarjetaScreen extends StatefulWidget {
  static String id = "validar_tarjeta_page";

  const ValidarTarjetaScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ValidarTarjetaScreen> createState() => _ValidarTarjetaScreenState();
}

class _ValidarTarjetaScreenState extends State<ValidarTarjetaScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        Alert.confirm(
          context,
          "¿Está seguro de salir, los cambios se van perder?",
          aceptar: () {
            Navigator.pop(context);
          },
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(245, 248, 250, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          title: const Text(
            "Confirmación",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Montserrat",
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          elevation: 0,
          leading: IconButton(
            onPressed: () async {
              Alert.confirm(
                context,
                "¿Está seguro de salir, los cambios se van perder?",
                aceptar: () {
                  Navigator.pop(context);
                },
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: size.height,
            child: Stack(alignment: Alignment.topCenter, children: [
              /**
               * 
               */
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        /**
                         * 
                         */
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Column(
                            children: [
                              const Text(
                                "Universidad Peruana Los Andes",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(41, 45, 67, 1),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              /**
                               * 
                               */
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                  left: 10,
                                  right: 10,
                                ),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color.fromRGBO(223, 240, 216, 1),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.info,
                                          color: Color.fromRGBO(51, 51, 51, 1),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Información:",
                                          style: TextStyle(
                                            color:
                                                Color.fromRGBO(51, 51, 51, 1),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Verifique sus datos antes de continuar; una ves realizado el pago, anularlo toma varios días.",
                                      style: TextStyle(
                                        color: Color.fromRGBO(51, 51, 51, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "S/ 1.00",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 27,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "MONTO TOTAL",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color.fromRGBO(41, 45, 67, 1),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              /**
                               * 
                               */
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: const [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Curso",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "ASDASD ASDASD ASDASDAS asdsad asdsad asdasq123123",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: const [
                                        Expanded(
                                          child: Text(
                                            "4111111111111",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 105, 105, 105),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: const [
                                        Expanded(
                                          child: Text(
                                            "Moneda Soles",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 105, 105, 105),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),

                              /**
                               * 
                               */
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromRGBO(0, 124, 188, 1),
                                    elevation: 0,
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.save,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "PROCESAR",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      ProcesandoPagoTramiteScreen.id,
                                    );
                                  },
                                ),
                              )

                              /**
                              * 
                              */
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /**
               * 
               */
            ]),
          ),
        ),
      ),
    );
  }
}
