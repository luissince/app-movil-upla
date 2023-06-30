import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/pages/home/widget/annotate_region_widget.dart';
import 'package:upla/ui/pages/home/widget/app_bar_ca_widget.dart';
import 'package:upla/ui/pages/home/perfil/centroayuda/widget/button_ca_widget.dart';

class SeguridadScreen extends StatefulWidget {
  static String id = "seguridad_page";

  const SeguridadScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SeguridadScreen> createState() => _SeguridadState();
}

class _SeguridadState extends State<SeguridadScreen> {
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
      appBar: AppBarCaWidget(title: "Seguridad").build(context),
      body: AnnotateRegionWidget(children: _main()).build(context),
    );
  }

  Widget _main() {
    return Column(
      children: [
        ButtonCentroAyudaWidget(
          icono: CupertinoIcons.lock_rotation,
          titulo: "Contraseña",
          detalle: "Editar tu contraseña para ingresar al app y la web",
          onPressed: () {},
        ),
      ],
    );
  }
}
