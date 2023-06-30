import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:upla/constants.dart';
import 'package:upla/ui/components/alert.dart';
import 'package:upla/ui/pages/home/academico/encuesta/encuenta_crear_screen.dart';

enum BestOpcionCalificacion { none, a, b, c, d, e }

class EncuetaScreen extends StatefulWidget {
  static String id = "encuesta_page";

  const EncuetaScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EncuetaScreen> createState() => _EncuetaScreenState();
}

class _EncuetaScreenState extends State<EncuetaScreen> {
  bool aceptar = false;

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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: _appTitle(),
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                children: [
                  _instrucciones(),
                  _aceptar(),
                  _continuar(),
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
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _instrucciones() {
    return const Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            CupertinoIcons.lightbulb,
            color: Color(0xffffd42f),
            size: 36,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "¡Hola!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "INSTRUCCIONES",
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1.",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  "Lea cada pregunta y marque la alternativa para cada docente según su apreciación.",
                  style: TextStyle(
                    height: 1.4,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "2.",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  "Marque una alternativa según la escala de valores (A, B, C, D ó E) para calificar a cada uno de sus docentes.",
                  style: TextStyle(
                    height: 1.4,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "3.",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  "Antes de pasar a la siguiente pregunta deberá calificar a todos sus docentes. Para los docentes de prácticas solo califique al docente que le enseñe dicho curso.",
                  style: TextStyle(
                    height: 1.4,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Recuerde: Solo se guardará la encuesta al completar las 30 preguntas.",
                  style: TextStyle(
                    height: 1.4,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _aceptar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
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
              child: const Text("Acepto haber leído las instrucciones"),
            ),
          )
        ],
      ),
    );
  }

  Widget _continuar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: _onEventContinuar,
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
        child:const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
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
    );
  }

  _onEventContinuar() {
    if (!aceptar) {
      Alert.show(context, "Acepta la condición para poder continuar.");
      return;
    }

    Navigator.pushReplacementNamed(
      context,
      EncuestaCrearScreen.id,
    );
  }
}
