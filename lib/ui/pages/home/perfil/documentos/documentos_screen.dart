import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/pages/home/perfil/centroayuda/widget/button_ca_widget.dart';
import 'package:upla/ui/pages/home/widget/annotate_region_widget.dart';
import 'package:upla/ui/pages/home/widget/app_bar_ca_widget.dart';

class DocumentosScreen extends StatefulWidget {
  static String id = "documentos_page";

  const DocumentosScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DocumentosScreen> createState() => _DocumentosState();
}

class _DocumentosState extends State<DocumentosScreen> {
  AppProvider? appProvider;

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBarCaWidget(title: "Documentos").build(context),
      body: AnnotateRegionWidget(children: _main()).build(context),
    );
  }

  Widget _main() {
    return Column(
      children: [
        ButtonCentroAyudaWidget(
          icono: CupertinoIcons.doc_plaintext,
          titulo: "Términos y Condiciones",
          detalle: "Sobre el uso del app y la web",
          onPressed: () {},
        ),
      ],
    );
  }
}
