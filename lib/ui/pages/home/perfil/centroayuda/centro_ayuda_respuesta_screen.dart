import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/constants.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/pages/home/home_screen.dart';

class CentroAyudaRespuestaScreen extends StatefulWidget {
  static String id = "centro_ayuda_respuesta_page";

  const CentroAyudaRespuestaScreen({Key? key}) : super(key: key);

  @override
  State<CentroAyudaRespuestaScreen> createState() =>
      _CentroAyudaRespuestaScreenState();
}

class _CentroAyudaRespuestaScreenState
    extends State<CentroAyudaRespuestaScreen> {
  AppProvider? appProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (appProvider!.response["state"]) {
        fetchDataBackground();
      }
    });
  }

  Future<void> fetchDataBackground() async {
    Map<String, dynamic> payload = {
      "codigo": "-",
      "titulo": appProvider!.payload["asunto"],
      "mensaje": appProvider!.payload["descripcion"]
    };
    appProvider!.notificarPregunta(payload);
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil(
          ModalRoute.withName(
            HomeScreen.id,
          ),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(245, 248, 250, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          title: const Text(
            "Centro de Ayuda",
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
                      child: const Column(
                        children: [
                          Text(
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
                     * 
                     */
                    if (appProvider!.response["state"])

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
                                const Icon(
                                  Icons.check_circle,
                                  color: Color.fromARGB(255, 15, 167, 84),
                                  size: 52,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  appProvider!.response["message"],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(51, 51, 51, 1),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    else
                      /**
                       * message error
                       */
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 15, right: 15),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromRGBO(242, 222, 222, 1),
                        ),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                const Icon(
                                  Icons.warning,
                                  color: Color.fromRGBO(169, 68, 66, 1),
                                  size: 52,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  appProvider!.response["message"],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(169, 68, 66, 1),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                    /**
                      * 
                      */
                    widgetRegresar()
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

  Widget widgetRegresar() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(0, 124, 188, 1),
          elevation: 0,
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.of(context).popUntil(ModalRoute.withName(
            HomeScreen.id,
          ));
        },
      ),
    );
  }
}
