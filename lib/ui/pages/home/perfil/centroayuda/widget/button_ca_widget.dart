import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonCentroAyudaWidget extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String detalle;
  final VoidCallback onPressed;

  const ButtonCentroAyudaWidget({
    super.key,
    required this.icono,
    required this.titulo,
    required this.detalle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffffffff)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(
                    icono,
                    color: const Color.fromRGBO(41, 45, 67, 1),
                    size: 23,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titulo,
                          style: const TextStyle(
                            color: Color.fromRGBO(41, 45, 67, 1),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          detalle,
                          style: const TextStyle(
                            color: Color.fromRGBO(41, 45, 67, 1),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Icon(
              CupertinoIcons.chevron_right,
              color: Color.fromRGBO(41, 45, 67, 1),
              size: 23,
            ),
          ],
        ),
      ),
    );
  }
}
