import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/constants.dart';
import 'package:upla/model/tramite.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/components/alert.dart';
import 'package:upla/ui/pages/home/financiero/realizarpagartramite/registrar_datos_tarjeta_screen.dart';

class RealizarPagoTramiteScreen extends StatefulWidget {
  static String id = "realizar_pago_tramite_page";

  const RealizarPagoTramiteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RealizarPagoTramiteScreen> createState() =>
      _RealizarPagoTramiteScreenState();
}

class _RealizarPagoTramiteScreenState extends State<RealizarPagoTramiteScreen> {
  AppProvider? appProvider;

  String idTramite = "";
  String nombreTramite = "SELECCIONE UN TRAMITE";
  String precio = "S/. 0.00";

  bool aceptUno = false;
  bool aceptDos = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 248, 250, 1),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          "Pagos y Tramites",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {},
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
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "REGISTRO DE FORMATO ÚNICO DE TRÁMITES EN LÍNEA",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: Color.fromRGBO(41, 45, 67, 1),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  "Código:",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color.fromRGBO(41, 45, 67, 1),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  appProvider!.session.docNumId!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color.fromRGBO(41, 45, 67, 1),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  "Nombre:",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color.fromRGBO(41, 45, 67, 1),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "${appProvider!.session.persNombre} ${appProvider!.session.persPaterno} ${appProvider!.session.persMaterno}",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color.fromRGBO(41, 45, 67, 1),
                                    fontWeight: FontWeight.w600,
                                  ),
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
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(217, 237, 247, 1),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.info,
                                color: Color.fromRGBO(22, 79, 107, 1),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "IMPORTANTE:",
                                style: TextStyle(
                                  color: Color.fromRGBO(22, 79, 107, 1),
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
                            "Seleccione el trámite que desea realizar, cada trámite tiene un costo diferente y depende de la Sede, la modalidad y la carrera profesional de cada estudiante.",
                            style: TextStyle(
                              color: Color.fromRGBO(22, 79, 107, 1),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Para cualquier consulta respecto a los trámites en línea que desea realizar, le dejamos nuestro directorio telefónico.",
                            style: TextStyle(
                              color: Color.fromRGBO(22, 79, 107, 1),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(0, 123, 255, 1),
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
                                    Icons.phone,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "DIRECTORIO TELEFÓNICO",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /**
                     * 
                     */
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(242, 222, 222, 1),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.warning,
                                color: Color.fromRGBO(169, 68, 66, 1),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "ADVERTENCIA:",
                                style: TextStyle(
                                  color: Color.fromRGBO(169, 68, 66, 1),
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
                            "El sistema validará si tiene deudas pendientes al seleccionar el trámite.",
                            style: TextStyle(
                              color: Color.fromRGBO(169, 68, 66, 1),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /**
                     * 
                     */
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
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
                                "Recuerda:",
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
                            style: TextStyle(
                              color: Color.fromRGBO(51, 51, 51, 1),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/twodeuda");
                              },
                              style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(0, 102, 0, 1),
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
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "ACTUALIZE SUS DATOS",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /**
                     * 
                     */
                    Row(
                      children: const [
                        Icon(Icons.bookmark),
                        Text("¿Que trámite desea realizar?:"),
                      ],
                    ),

                    /**
                     * 
                     */
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _mySheet();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Color.fromRGBO(41, 45, 67, 1),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              idTramite == "" ? Icons.expand_more : Icons.check,
                              color: idTramite == ""
                                  ? const Color.fromRGBO(41, 45, 67, 0.5)
                                  : const Color.fromRGBO(41, 45, 67, 1),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              nombreTramite,
                              style: TextStyle(
                                color: idTramite == ""
                                    ? const Color.fromRGBO(41, 45, 67, 0.5)
                                    : const Color.fromRGBO(41, 45, 67, 1),
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /**
                     * 
                     */
                    Column(
                      children: [
                        const Text("Costo de trámite seleccionado"),
                        Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: kPrimaryColor,
                            ),
                            child: Text(
                              precio,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ))
                      ],
                    ),

                    /**
                     * 
                     */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: aceptUno,
                          onChanged: (value) {
                            setState(() {
                              aceptUno = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                aceptUno = !aceptUno;
                              });
                            },
                            child: const Text(
                                "Acepto el uso de mis datos personales por la Universidad."),
                          ),
                        )
                      ],
                    ),
                    /**
                     * 
                     */
                    Row(
                      children: [
                        Checkbox(
                          value: aceptDos,
                          onChanged: (value) {
                            setState(() {
                              aceptDos = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                aceptDos = !aceptDos;
                              });
                            },
                            child: const Text(
                                "Acepto que el costo de trámite se envie al banco"),
                          ),
                        )
                      ],
                    ),
                    /**
                     * 
                     */
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _onPay,
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
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "CONTINUAR",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
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
          ),
        ),
      ),
    );
  }

  _mySheet() {
    Size size = MediaQuery.of(context).size;
    List<Tramite> list = [
      Tramite(1, "k001", "ACTAS", 100.00),
      Tramite(1, "k002", "ACTUALIZACION DE MATRICULA", 40.50),
      Tramite(1, "k003", "CAMBIO DE MODALIDAD", 18.80)
    ];

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: const Color(0xFF737373),
          height: (size.height * 0.6),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, i) {
                Tramite tramite = list[i];
                return ListTile(
                  leading: const Icon(Icons.check),
                  title: Text(
                    tramite.nombre,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(41, 45, 67, 1),
                      fontSize: 13,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      idTramite = tramite.idTramite;
                      nombreTramite = tramite.nombre;
                      precio = "S/. ${tramite.precio.toStringAsFixed(2)}";
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  _onPay() {
    if (idTramite == "") {
      Alert(context).showAlert("Seleccione un Tramite.");
      return;
    }

    if (!aceptUno) {
      Alert(context).showAlert("Acepta las condiciones.");
      return;
    }

    if (!aceptDos) {
      Alert(context).showAlert("Acepta las condiciones.");
      return;
    }

    Navigator.pushReplacementNamed(
      context,
      RegistrarDatosTarjetaScreen.id,
    );
  }
}
