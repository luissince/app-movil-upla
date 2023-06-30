import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/constants.dart';
import 'package:upla/provider/app_provider.dart';

class RegistrarMatriculaScreen extends StatefulWidget {
  static String id = "registrar_matricula_page";

  @override
  State<StatefulWidget> createState() => _RegistrarMatriculaScreenState();
}

class _RegistrarMatriculaScreenState extends State<RegistrarMatriculaScreen> {
  AppProvider? appProvider;

  CancelToken cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  void dispose() {
    cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          "Registrar Matrícula",
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                child: Column(
                  children: [],
                ),
              )),
        ),
      ),
    );
  }
}
