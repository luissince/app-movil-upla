import 'package:flutter/material.dart';

class TitleConstanciaMatricula extends StatelessWidget {
  final String plan;

  TitleConstanciaMatricula({Key? key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Universidad Peruana Los Andes",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17,
            color: Color.fromRGBO(41, 45, 67, 1),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          "Dirección Universitaría de Desarrollo Académico",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: Color.fromARGB(255, 163, 163, 163),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "CONSTANCIA DE MATRÍCULA $plan PRESENCIAL",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            color: Color.fromRGBO(41, 45, 67, 1),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          "ESTE DOCUMENTO ES VÁLIDO PARA CONTROL DE SU MATRICULA",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: Color.fromARGB(255, 218, 14, 14),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
