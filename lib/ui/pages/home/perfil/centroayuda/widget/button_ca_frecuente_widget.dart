import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:upla/constants.dart';
import 'package:upla/ui/components/alert.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtonCaFrecuenteWidget extends StatelessWidget {
  final String titulo;
  final String detalle;
  final bool expanded;
  final VoidCallback onPressed;
  final BuildContext context;

  const ButtonCaFrecuenteWidget({
    super.key,
    required this.titulo,
    required this.detalle,
    required this.expanded,
    required this.onPressed,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    bool esUrlValida = Uri.parse(detalle).isAbsolute;

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Color(0xfff1f1f1),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
                bottom: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      titulo,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    !expanded
                        ? CupertinoIcons.chevron_down
                        : CupertinoIcons.chevron_up,
                    color: kPrimaryColor,
                    size: 26,
                  )
                ],
              ),
            ),
          ),
          if (esUrlValida)
            SizedBox(
              height: expanded ? null : 0,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 0,
                  bottom: 10,
                  left: 20,
                  right: 20,
                ),
                child: SelectableText.rich(
                  TextSpan(
                    text: detalle,
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _abrirEnlace(Uri.parse(detalle));
                      },
                  ),
                ),
              ),
            )
          else
            SizedBox(
              height: expanded ? null : 0,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 0,
                  bottom: 10,
                  left: 20,
                  right: 20,
                ),
                child: SelectableText(
                  detalle,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 13,
                    color: Colors.black,
                    height: 1.4,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  void _abrirEnlace(Uri enlace) async {
    try {
      await launchUrl(enlace,mode: LaunchMode.externalApplication);
    } catch (err) {
      _abrirMensaje(enlace);
    }
  }

  void _abrirMensaje(Uri enlace) {
    Alert(context).showAlert("No se pudo abrir el enlace: $enlace");
  }
}
