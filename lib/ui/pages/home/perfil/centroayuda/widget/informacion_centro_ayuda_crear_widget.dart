import 'package:flutter/cupertino.dart';

class InformacionCentroAyudaCrearWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
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
            "Accede y absuelve todas tus consultas buscando en la sección preguntas frecuentes. Si no encuentras la respuesta que buscas, registra tu consulta especifica en los campo siguientes.",
          ),
        ],
      ),
    );
  }
}
