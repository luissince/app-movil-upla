import 'package:flutter/material.dart';
import 'package:upla/constants.dart';
import 'package:upla/ui/components/activity_indicator.dart';

class HeadConstanciaMatricula extends StatelessWidget {
  final bool loading;
  final bool responde;
  final String message;
  final String facultad;
  final String carrera;
  final String docNumId;
  final String persNombre;
  final String persPaterno;
  final String persMaterno;

  HeadConstanciaMatricula({
    Key? key,
    required this.loading,
    required this.responde,
    required this.message,
    required this.facultad,
    required this.carrera,
    required this.docNumId,
    required this.persNombre,
    required this.persPaterno,
    required this.persMaterno,
  });

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Column(
        children: const [
          ActivityIndicator(
            color: kPrimaryColor,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Cargando Información...",
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      );
    }

    if (!responde) {
      return Column(
        children: [
          const Icon(
            Icons.warning,
            color: Color.fromRGBO(254, 1, 3, 1),
            size: 37,
          ),
          Text(
            textAlign: TextAlign.center,
            message,
            style: const TextStyle(
              color: kPrimaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      );
    }

    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text(
                "Facultad:",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                facultad,
                style: const TextStyle(
                  fontSize: 13,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
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
                "E.A.P:",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                carrera,
                style: const TextStyle(
                  fontSize: 13,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: const [
            Expanded(
              flex: 1,
              child: Text(
                "Especialidad:",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                "---------",
                style: TextStyle(
                  fontSize: 13,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
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
                "Código:",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                docNumId,
                style: const TextStyle(
                  fontSize: 13,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
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
                "Alumno:",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                "${persNombre} ${persPaterno} ${persMaterno}",
                style: const TextStyle(
                  fontSize: 13,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
