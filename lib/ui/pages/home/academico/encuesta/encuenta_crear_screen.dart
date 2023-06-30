import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/constants.dart';
import 'package:upla/model/docente.dart';
import 'package:upla/model/encuesta_pregunta_detalle.dart';
import 'package:upla/model/escala.dart';
import 'package:upla/model/pregunta.dart';
import 'package:upla/network/exception/rest_error.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/components/activity_indicator.dart';
import 'package:upla/ui/components/alert.dart';
import 'package:upla/ui/pages/home/academico/encuesta/encuesta_procesando_screen.dart';

class EncuestaCrearScreen extends StatefulWidget {
  static String id = "encuesta_crear_page";

  const EncuestaCrearScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EncuestaCrearScreen> createState() => _EncuestaCrearScreenState();
}

class _EncuestaCrearScreenState extends State<EncuestaCrearScreen> {
  AppProvider? appProvider;

  bool loadingEncuesta = false;
  bool responseEncuestaOk = true;
  String messageEncuesta = "";

  final ScrollController _scrollController = ScrollController();

  double _progressValue = 0.0;
  int posList = 0;
  int posSigu = 0;
  double posComp = 0;
  bool compEncu = false;
  bool aceptar = false;
  List<Pregunta> list = [];

  CancelToken cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadPreguntas();
    });
  }

  @override
  void dispose() async {
    cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);

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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: _appTitle(),
        body: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20,),
              child: Column(
                children: [
                  /**
                   * 
                   */
                  _progresoWidget(),
                  /**
                   * 
                   */
                  _escalaValoresWidget(),
                  /**
                   * 
                   */
                  _posicionWidget(),
                  /**
                   * 
                   */
                  _anteriorWidget(),
                  /**
                   * 
                   */
                  _continuarWidget(),
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

  AppBar _appTitle() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: const Text(
        "Encuesta",
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
    );
  }

  Widget _progresoWidget() {
    if (loadingEncuesta) {
      return const SizedBox();
    }

    String porcentaje = (_progressValue * 100.00).toStringAsFixed(0);
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: LinearProgressIndicator(
              minHeight: 30,
              value: _progressValue,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "$porcentaje%",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _escalaValoresWidget() {
    if (loadingEncuesta || list.isEmpty) return const SizedBox();

    if (compEncu) {
      return const Text(
        "Si está seguro que todas sus respuestas fueron marcadas correctamente haga clic en guardar, caso contrario haga clic en anterior para verificar sus respuestas.",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      );
    }

    Pregunta pregunta = list[posList];

    return Column(
      children: [
        const Text(
          "Escala de valores",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
            children: pregunta.listEscala!.map(
          (Escala escala) {
            return Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 7,
                    bottom: 7,
                  ),
                  decoration: BoxDecoration(
                    color: escala.color,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Text(escala.tipo),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(escala.nombre),
              ],
            );
          },
        ).toList())
      ],
    );
  }

  Widget _posicionWidget() {
    if (loadingEncuesta || list.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Column(
          children: [
            ActivityIndicator(
              color: kPrimaryColor,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Cargando encuesta...",
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      );
    }

    if (!responseEncuestaOk) {
      return Column(
        children: [
          const Icon(
            Icons.warning,
            color: Color.fromRGBO(254, 1, 3, 1),
            size: 37,
          ),
          Text(
            textAlign: TextAlign.center,
            messageEncuesta,
            style: const TextStyle(
              color: kPrimaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      );
    }

    if (compEncu) {
      return Row(
        children: [
          Checkbox(
            value: aceptar,
            onChanged: (value) {
              setState(() {
                aceptar = value!;
              });
            },
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  aceptar = !aceptar;
                });
              },
              child: const Text(
                  "Acepto haber leído y respondido cada pregunta con mucho criterio."),
            ),
          )
        ],
      );
    }

    Pregunta pregunta = list[posList];

    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: Column(children: [
        Container(
          margin: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: Text(
            pregunta.cNombrePregunta!,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Column(
          children: pregunta.listDocente!.map((Docente docente) {
            return docente.key! % 2 == 0
                ? _preguntaWidget(
                    const Color.fromARGB(255, 245, 245, 245),
                    docente.key!,
                    pregunta.idPregunta!,
                    docente.cLe_Auto!,
                    docente.asi_Id!,
                    docente.per_Id!,
                    docente.nombre!,
                    docente.asi_Asignatura!,
                    docente.tipoDocente!,
                    docente.bestOpcionCalificacion,
                    docente.listPregunta!,
                    pregunta.listDocente!.length,
                  )
                : _preguntaWidget(
                    const Color.fromARGB(255, 230, 230, 230),
                    docente.key!,
                    pregunta.idPregunta!,
                    docente.cLe_Auto!,
                    docente.asi_Id!,
                    docente.per_Id!,
                    docente.nombre!,
                    docente.asi_Asignatura!,
                    docente.tipoDocente!,
                    docente.bestOpcionCalificacion,
                    docente.listPregunta!,
                    pregunta.listDocente!.length,
                  );
          }).toList(),
        )
      ]),
    );
  }

  Widget _preguntaWidget(
    Color color,
    int key,
    int idPregunta,
    int cleAuto,
    String asiId,
    String perId,
    String docente,
    String asignatura,
    String tipo,
    BestOpcionCalificacion bestOpcionCalificacion,
    List<Pregunta> listPregunta,
    int length,
  ) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: key == 1
              ? const Radius.circular(10.0)
              : const Radius.circular(0.0),
          topRight: key == 1
              ? const Radius.circular(10.0)
              : const Radius.circular(0.0),
          bottomLeft: length == key
              ? const Radius.circular(10.0)
              : const Radius.circular(0.0),
          bottomRight: length == key
              ? const Radius.circular(10.0)
              : const Radius.circular(0.0),
        ),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
          bottom: 0,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    "N°:",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "$key",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
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
                    "Tipo:",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    tipo,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
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
                    "Docente:",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    docente,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
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
                    "Curso:",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    asignatura,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            /**
             * Lista de escala
             */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: listPregunta.map((Pregunta preguta) {
                return Row(
                  children: [
                    Text(preguta.escala!),
                    Radio(
                      value: preguta.bestOpcionCalificacion!,
                      groupValue: bestOpcionCalificacion,
                      onChanged: (BestOpcionCalificacion? value) {
                        _seleccionarRadioButton(
                            "$idPregunta$cleAuto$asiId$perId", value!);
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _anteriorWidget() {
    if (loadingEncuesta) return const SizedBox();

    if (posList <= 0) return const SizedBox();

    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (posList <= 0) {
            return;
          }

          if (!compEncu) posSigu--;

          setState(() {
            compEncu = false;
            posList = posSigu;
            _progressValue -= posComp;
          });
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color.fromRGBO(0, 124, 188, 1)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "ANTERIOR",
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _continuarWidget() {
    if (loadingEncuesta) {
      return const SizedBox();
    }

    if (compEncu) {
      return Container(
        margin: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _preguntasCompletas,
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color.fromRGBO(0, 124, 188, 1),
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
                Icons.save,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "GUARDAR",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          int validar = 0;

          Pregunta pregunta = list[posList];

          for (Docente en in pregunta.listDocente!) {
            if (en.bestOpcionCalificacion == BestOpcionCalificacion.none) {
              validar++;
            }
          }

          if (validar != 0) {
            Alert.show(
                context, "Marque todas las preguntas para poder continuar.");
            return;
          }

          if (list.length - 1 == posList) {
            setState(() {
              compEncu = true;
              _progressValue += posComp;
            });
            return;
          }

          posSigu++;

          setState(() {
            posList = posSigu;
            _progressValue += posComp;
          });

          _scrollController.jumpTo(0.0);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color.fromRGBO(0, 124, 188, 1),
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
              Icons.arrow_forward,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "SIGUIENTE",
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _seleccionarRadioButton(
      String id, BestOpcionCalificacion bestOpcionCalificacion) {
    List<Pregunta> newList = [...list];

    for (Pregunta li in newList) {
      for (Docente en in li.listDocente!) {
        int v0 = li.idPregunta!;
        int v1 = en.cLe_Auto!;
        String v2 = en.asi_Id!;
        String v3 = en.per_Id!;
        if ("$v0$v1$v2$v3" == id) {
          en.bestOpcionCalificacion = bestOpcionCalificacion;
          break;
        }
      }
    }

    setState(() {
      list = newList;
    });
  }

  void _preguntasCompletas() async {
    if (!aceptar) {
      Alert.show(context, "Debe aceptar para poder continuar.");
      return;
    }

    List<EncuestaPreguntaDetalle> lpd = [];

    for (Pregunta pregunta in list) {
      for (Docente docente in pregunta.listDocente!) {
        int preguntav = 0;
        int escalav = 0;
        for (Pregunta escala in docente.listPregunta!) {
          if (docente.bestOpcionCalificacion == escala.bestOpcionCalificacion) {
            preguntav = escala.idPregunta!;
            escalav = escala.puntajeEscala!;
            break;
          }
        }
        lpd.add(
          EncuestaPreguntaDetalle(
            docente.sed_Id!,
            docente.mAc_Id!,
            docente.car_Id!,
            docente.per_Id!,
            docente.asi_Id!,
            docente.nta_Nivel!,
            docente.nta_Seccion!,
            preguntav.toString(),
            escalav.toString(),
          ),
        );
      }
    }

    appProvider!.listaEncuestaPregunta = lpd;

    Navigator.pushReplacementNamed(
      context,
      EncuestaProcesandoScreen.id,
    );
  }

  Future<void> loadPreguntas() async {
    if (loadingEncuesta) {
      return;
    }

    setState(() {
      loadingEncuesta = true;
      responseEncuestaOk = false;
    });

    dynamic response = await appProvider!.estudianteComprobarEncuesta(
      cancelToken: cancelToken,
    );

    if (response is Response) {
      _generarEncuesta();
    }

    if (response is RestError) {
      if (response.type == DioErrorType.cancel) return;

      // ignore: use_build_context_synchronously
      Alert.show(context, response.message, callback: () {
        Navigator.pop(context);
      });
    }
  }

  void _generarEncuesta() async {
    dynamic response = await appProvider!
        .estudianteListaPreguntaEncuesta(cancelToken: cancelToken);

    if (response is Response) {
      var jsonData = response.data;
      List<dynamic> listPreguntas = jsonData["preguntas"];
      List<dynamic> listDocentes = jsonData["docentes"];

      List<Pregunta> preguntas = [];
      int countPregunta = 0;

      for (var pregunta in listPreguntas) {
        if (!_duplicadoPregunta(preguntas, pregunta["idPregunta"])) {
          preguntas.add(
            Pregunta.Only(
              countPregunta,
              pregunta["idPregunta"],
              pregunta["cNombrePregunta"],
            ),
          );
        }
      }

      for (Pregunta pregunta in preguntas) {
        int countDocente = 0;
        List<Docente> docentes = [];
        for (var docente in listDocentes) {
          int countPregunta = 0;
          List<Pregunta> preguntas = [];
          for (var item in listPreguntas) {
            if (item["idPregunta"] == pregunta.idPregunta) {
              if (item["puntajeEscala"] != null) {
                if (item["puntajeEscala"] == 5) {
                  countPregunta++;
                  preguntas.add(
                    Pregunta.Escala(
                      countPregunta,
                      item["idPregunta"],
                      item["cNombreEscala"],
                      item["puntajeEscala"],
                      BestOpcionCalificacion.a,
                      "A",
                      const Color.fromARGB(255, 43, 168, 47),
                    ),
                  );
                }

                if (item["puntajeEscala"] == 4) {
                  countPregunta++;
                  preguntas.add(
                    Pregunta.Escala(
                      countPregunta,
                      item["idPregunta"],
                      item["cNombreEscala"],
                      item["puntajeEscala"],
                      BestOpcionCalificacion.b,
                      "B",
                      const Color.fromARGB(255, 123, 216, 126),
                    ),
                  );
                }

                if (item["puntajeEscala"] == 3) {
                  countPregunta++;
                  preguntas.add(
                    Pregunta.Escala(
                      countPregunta,
                      item["idPregunta"],
                      item["cNombreEscala"],
                      item["puntajeEscala"],
                      BestOpcionCalificacion.c,
                      "C",
                      Colors.yellow,
                    ),
                  );
                }

                if (item["puntajeEscala"] == 2) {
                  countPregunta++;
                  preguntas.add(
                    Pregunta.Escala(
                      countPregunta,
                      item["idPregunta"],
                      item["cNombreEscala"],
                      item["puntajeEscala"],
                      BestOpcionCalificacion.d,
                      "D",
                      Colors.orange,
                    ),
                  );
                }

                if (item["puntajeEscala"] == 1) {
                  countPregunta++;
                  preguntas.add(
                    Pregunta.Escala(
                      countPregunta,
                      item["idPregunta"],
                      item["cNombreEscala"],
                      item["puntajeEscala"],
                      BestOpcionCalificacion.e,
                      "E",
                      Colors.red,
                    ),
                  );
                }
              }
            }
          }

          countDocente++;
          docentes.add(
            Docente(
              countDocente,
              docente["cLe_Auto"],
              docente["asi_Id"],
              docente["asi_Asignatura"],
              docente["per_Id"],
              docente["nombre"],
              docente["sed_Id"],
              docente["car_Id"],
              docente["mAc_Id"],
              docente["nta_Nivel"],
              docente["nta_Seccion"],
              docente["tipoDocente"],
              preguntas,
              BestOpcionCalificacion.none,
            ),
          );
        }
        int countEscala = 0;
        List<Escala> escalas = [];

        for (var item in listPreguntas) {
          if (item["idPregunta"] == pregunta.idPregunta) {
            if (item["puntajeEscala"] != null) {
              if (item["puntajeEscala"] == 5) {
                countEscala++;
                escalas.add(
                  Escala(
                    countEscala,
                    item["cNombreEscala"],
                    "A",
                    const Color.fromARGB(255, 43, 168, 47),
                  ),
                );
              }

              if (item["puntajeEscala"] == 4) {
                countEscala++;
                escalas.add(
                  Escala(
                    countEscala,
                    item["cNombreEscala"],
                    "B",
                    const Color.fromARGB(255, 123, 216, 126),
                  ),
                );
              }

              if (item["puntajeEscala"] == 3) {
                countEscala++;
                escalas.add(
                  Escala(
                    countEscala,
                    item["cNombreEscala"],
                    "C",
                    Colors.yellow,
                  ),
                );
              }

              if (item["puntajeEscala"] == 2) {
                countEscala++;
                escalas.add(
                  Escala(
                    countEscala,
                    item["cNombreEscala"],
                    "D",
                    Colors.orange,
                  ),
                );
              }

              if (item["puntajeEscala"] == 1) {
                countEscala++;
                escalas.add(
                  Escala(
                    countEscala,
                    item["cNombreEscala"],
                    "E",
                    Colors.red,
                  ),
                );
              }
            }
          }
        }

        pregunta.listDocente = docentes;

        pregunta.listEscala = escalas;
      }

      setState(() {
        list = preguntas;
        posComp = (100 / preguntas.length) / 100;
        loadingEncuesta = false;
        responseEncuestaOk = true;
      });
    }
  }

  bool _duplicadoPregunta(List<Pregunta> list, int idPregunta) {
    bool duplicado = false;
    for (Pregunta pregunta in list) {
      if (pregunta.idPregunta == idPregunta) {
        duplicado = true;
        break;
      }
    }
    return duplicado;
  }
}
