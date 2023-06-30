import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/constants.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/components/alert.dart';
import 'package:upla/ui/pages/home/perfil/centroayuda/centro_ayuda_procesando_screen.dart';
import 'package:upla/ui/pages/home/perfil/centroayuda/widget/informacion_centro_ayuda_crear_widget.dart';

class CentroAyudaCrearScreen extends StatefulWidget {
  static String id = "centro_ayuda_crear_screen_page";

  const CentroAyudaCrearScreen({Key? key}) : super(key: key);

  @override
  State<CentroAyudaCrearScreen> createState() => _CentroAyudaCrearScreenState();
}

class _CentroAyudaCrearScreenState extends State<CentroAyudaCrearScreen> {
  AppProvider? appProvider;

  TextEditingController textFieldAsunto = TextEditingController();
  TextEditingController textFieldDescripcion = TextEditingController();

  FocusNode focusNodeAsunto = FocusNode();
  FocusNode focusNodeDescripcion = FocusNode();

  String idTipoConsulta = "";
  String nombreTipoConsulta = "Seleccione";

  String asuntoLength = "Min. 10 caracteres.";
  String descripcionLength = "Min. 20 caracteres.";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    focusNodeAsunto.dispose();
    focusNodeDescripcion.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          "Registrar - un comentario",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 15,
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
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Column(
                children: [
                  /**
                   * 
                   */
                  InformacionCentroAyudaCrearWidget(),
                  /**
                   * 
                   */
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Asunto",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          focusNode: focusNodeAsunto,
                          controller: textFieldAsunto,
                          onChanged: (value) async {
                            int min = 10 - textFieldAsunto.text.length;
                            setState(() {
                              asuntoLength = min <= 0
                                  ? "Todo bien"
                                  : "Min. $min caracteres.";
                            });
                          },
                          onFieldSubmitted: (value) async {
                            sendConsulta();
                          },
                          cursorColor: kPrimaryColor,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 5,
                              bottom: 5,
                            ),
                            hintText: "Asunto de la consulta",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          asuntoLength,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: asuntoLength == "Todo bien"
                                ? Colors.green
                                : Colors.red,
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
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tipo de consulta",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _mySheet();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            // primary: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.only(
                              top: 15,
                              bottom: 15,
                              left: 10,
                              right: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Color.fromRGBO(153, 153, 153, 1),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                size: 19,
                                Icons.expand_more,
                                color: Color.fromARGB(255, 104, 104, 104),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                nombreTipoConsulta,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 104, 104, 104),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Descripción",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          focusNode: focusNodeDescripcion,
                          controller: textFieldDescripcion,
                          minLines: 6,
                          maxLines: null,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          onChanged: (value) async {
                            int min = 20 - textFieldDescripcion.text.length;
                            setState(() {
                              descripcionLength = min <= 0
                                  ? "Todo bien"
                                  : "Min. $min caracteres.";
                            });
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 5,
                              bottom: 5,
                            ),
                            hintText: "Descripción de la consulta.",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          descripcionLength,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: descripcionLength == "Todo bien"
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ],
                    ),
                  ),

                  /**
                   * 
                   */
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // foregroundColor: const Color.fromRGBO(0, 124, 188, 1),
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
                      onPressed: sendConsulta,
                      child:  const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Generar Ticket",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )

                  /**
                   * 
                   */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendConsulta() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if (textFieldAsunto.text.trim() == "") {
      Alert(context).showAlert("Ingrese el asunto por favor.", callback: () {
        focusNodeAsunto.requestFocus();
      });

      return;
    }

    if (textFieldAsunto.text.trim().length < 10) {
      Alert(context).showAlert(
          "El asunto debe tener un mínimo de 10 caracteres.", callback: () {
        focusNodeAsunto.requestFocus();
      });

      return;
    }

    if (idTipoConsulta == "") {
      Alert(context).showAlert("Selecione el tipo de consulta.", callback: () {
        focusNodeAsunto.requestFocus();
      });

      return;
    }

    if (textFieldDescripcion.text.trim() == "") {
      Alert(context).showAlert(
          "La descripción del asunto debe tener un mínimo de 20 caracteres.",
          callback: () {
        focusNodeAsunto.requestFocus();
      });

      return;
    }

    if (textFieldDescripcion.text.trim().length < 20) {
      Alert(context).showAlert(
          "La descripción del asunto debe tener un mínimo de 20 caracteres.",
          callback: () {
        focusNodeDescripcion.requestFocus();
      });

      return;
    }

    Map<String, dynamic> payload = {
      "id": 0,
      "idConsulta": "string",
      "ticket": "string",
      "asunto": textFieldAsunto.text.trim(),
      "tipoConsulta": idTipoConsulta,
      "tipoConsultaDetalle": "",
      "alumno": "",
      "descripcion": textFieldDescripcion.text.trim(),
      "estado": 1,
      "estado_descripcion": "string",
      "fecha": "string",
      "hora": "string",
      "est_Id": appProvider?.session.docNumId,
      "est_NumDoc": "",
      "c_cod_usuario": appProvider?.session.docNumId,
      "contacto": "string"
    };

    appProvider!.payload = payload;

    Navigator.pushReplacementNamed(
      context,
      CentroAyudaProcesandoScreen.id,
    );
  }

  _mySheet() {
    Size size = MediaQuery.of(context).size;
    List<Map<String, dynamic>> list = [
      {
        "idTipoConsulta": "1",
        "nombre": "Atención",
      },
      {
        "idTipoConsulta": "2",
        "nombre": "Incidencia",
      },
      {
        "idTipoConsulta": "3",
        "nombre": "Orientación",
      },
      {
        "idTipoConsulta": "4",
        "nombre": "Queja o reclamo",
      },
      {
        "idTipoConsulta": "5",
        "nombre": "Sugencia",
      },
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
                Map<String, dynamic> tramite = list[i];
                return ListTile(
                  leading: const Icon(Icons.check),
                  title: Text(
                    tramite["nombre"],
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 104, 104, 104),
                      fontSize: 13,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      idTipoConsulta = tramite["idTipoConsulta"];
                      nombreTipoConsulta = tramite["nombre"];
                    });
                    Navigator.of(context).pop();
                    if (textFieldDescripcion.text == "") {
                      focusNodeDescripcion.requestFocus();
                    }
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
