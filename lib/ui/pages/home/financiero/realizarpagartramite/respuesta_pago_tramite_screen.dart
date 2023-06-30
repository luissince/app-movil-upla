import 'package:flutter/material.dart';
import 'package:upla/constants.dart';
import 'package:upla/ui/pages/home/financiero/realizarpagartramite/realizar_pago_tramite_screen.dart';

class RespuestaPagoTramiteScreen extends StatefulWidget {
  static String id = "respuesta_pago_tramite_page";

  const RespuestaPagoTramiteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RespuestaPagoTramiteScreen> createState() =>
      _RespuestaPagoTramiteScreenState();
}

class _RespuestaPagoTramiteScreenState
    extends State<RespuestaPagoTramiteScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(
          context,
          RealizarPagoTramiteScreen.id,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(245, 248, 250, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          title: const Text(
            "Pago",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Montserrat",
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
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
                          /**
                           * 
                           */
                        ],
                      ),
                    ),
                    /**
                     * message error
                     */
                    // Container(
                    //   width: double.infinity,
                    //   margin: const EdgeInsets.only(
                    //       top: 10, bottom: 10, left: 15, right: 15),
                    //   padding: const EdgeInsets.all(10),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(5),
                    //     color: const Color.fromRGBO(242, 222, 222, 1),
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       Column(
                    //         children: [
                    //           Icon(
                    //             Icons.warning,
                    //             color: Color.fromRGBO(169, 68, 66, 1),
                    //             size: 52,
                    //           ),
                    //           SizedBox(
                    //             width: 5,
                    //           ),
                    //           Text(
                    //             "SE GENERO UN PROBLEMA",
                    //             style: TextStyle(
                    //               color: Color.fromRGBO(169, 68, 66, 1),
                    //               fontSize: 11,
                    //               fontWeight: FontWeight.w700,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       const SizedBox(
                    //         height: 10,
                    //       ),
                    //       const Text(
                    //         "Se le va a cobrar un monto adicional por transacción de plataforma.",
                    //         textAlign: TextAlign.justify,
                    //         style: TextStyle(
                    //           color: Color.fromRGBO(169, 68, 66, 1),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    /**
                     * message success
                     */
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 15, right: 15),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(15, 167, 84, 0.3),
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Color.fromARGB(255, 15, 167, 84),
                                size: 52,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "COBRO REGISTRADO CORRECTAMENTE",
                                style: TextStyle(
                                  color: Color.fromRGBO(51, 51, 51, 1),
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
                            "Actualizar tus datos como correo, celular, teléfono, entre otros para informarle sobre su trámite.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Color.fromRGBO(51, 51, 51, 1),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /**
                      * 
                      */
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(0, 124, 188, 1),
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
                              Icons.home,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "REGRESAR",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            RealizarPagoTramiteScreen.id,
                          );
                        },
                      ),
                    ),

                    /**
                     * 
                     */
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
