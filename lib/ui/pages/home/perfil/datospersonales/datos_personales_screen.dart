import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/constants.dart';
import 'package:upla/model/datos_ficha.dart';
import 'package:upla/network/exception/rest_error.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/components/activity_indicator.dart';
import 'package:upla/ui/pages/home/widget/app_bar_ca_widget.dart';

class DatosPersonalesScreen extends StatefulWidget {
  static String id = "datos_personales_page";

  const DatosPersonalesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DatosPersonalesScreen> createState() => _DatosPersonalesState();
}

class _DatosPersonalesState extends State<DatosPersonalesScreen> {
  AppProvider? appProvider;

  bool vista = true;
  bool cargando = false;
  bool respuestaOk = false;
  String mensaje = "";
  late DatosFicha datosFicha;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generarInformacion();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);

   // Construir la pantalla principal
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBarCaWidget(title: "Datos Personales").build(context),
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: _generarVista(),
        ),
      ),
    );
  }

  // Método para generar la vista según el estado de carga y respuesta
  Widget _generarVista() {
    // Verificar si la vista ya está cargada
    if (vista) {
      return const SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ActivityIndicator(color: kPrimaryColor),
              SizedBox(
                height: 10,
              ),
              Text(
                "",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      );
    }

    // Verificar si se está cargando la información
    if (cargando) {
      return const SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ActivityIndicator(color: kPrimaryColor),
              SizedBox(
                height: 10,
              ),
              Text(
                "Cargando información...",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      );
    }

    // Verificar si hay un error en la respuesta
    if (!respuestaOk) {
      return const SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.warning,
                color: Color.fromRGBO(254, 1, 3, 1),
                size: 37,
              ),
              Text(
                textAlign: TextAlign.center,
                "Error al cargar la información!",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      );
    }

    // Si no hay problemas, mostrar la vista con los datos obtenidos
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          _contenedorTitulo("Datos Académicos", Icons.domain),
          _contenedorDatos("Código", datosFicha.codigo),
          _contenedorDatos("Facultad", datosFicha.facultad),
          _contenedorDatos("Carrera", datosFicha.carrera),
          _contenedorDatos("Modalidad", datosFicha.modalidadAcademico),
          _contenedorDatos("Fecha de Ingreso", datosFicha.fechaIngreso),
          _contenedorTitulo("Datos Personales", Icons.person),
          _contenedorDatos("N° DNI", datosFicha.dni),
          _contenedorDatos("Nombres", datosFicha.nombres),
          _contenedorDatos("Apellido Paterno", datosFicha.apellidoPaterno),
          _contenedorDatos("Apellido Materno", datosFicha.apellidoMaterno),
          _contenedorDatos("N° de Teléfono", datosFicha.telefono),
          _contenedorDatos("N° de Celular", datosFicha.celular),
          _contenedorDatos("Correo Electrónico", datosFicha.mail),
          _contenedorDatos("Dirección", datosFicha.direccion),
          _contenedorDatos("Fecha de Nacimiento", datosFicha.fechaNacimiento),
        ],
      ),
    );
  }

  // Widget para mostrar un contenedor con título y un ícono
  Widget _contenedorTitulo(String nombre, IconData iconData) {
    return Container(
      // Establecer margen
      margin: const EdgeInsets.only(bottom: 10),
      // Establecer padding
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: 10,
      ),
      // Establecer ancho para ocupar todo el ancho disponible
      width: double.infinity,
      // Establecer decoración para un borde inferior
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Color.fromARGB(255, 197, 197, 197),
          ),
        ),
      ),
      // Crear una fila para mostrar el ícono y el título
      child: Row(
        children: [
          // Mostrar el ícono proporcionado
          Icon(iconData),
          // Agregar un pequeño espacio entre el ícono y el texto
          const SizedBox(
            width: 5,
          ),
          // Mostrar el texto del título proporcionado
          Text(
            nombre,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Widget para mostrar un contenedor con datos y título
  Widget _contenedorDatos(String titulo, String informacion) {
    return Container(
      // Establecer margen
      margin: const EdgeInsets.only(bottom: 10),
      // Establecer padding
      padding: const EdgeInsets.only(
         left: 20,
        right: 20,
        top: 10,
        bottom: 5,
      ),
      // Establecer ancho para ocupar todo el ancho disponible
      width: double.infinity,
      // Establecer decoración para un borde inferior
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Color(0xfff1f1f1),
          ),
        ),
      ),
      // Crear una columna para mostrar el título y la información
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mostrar el título
          Text(
            titulo,
            style: const TextStyle(
              color: Color.fromRGBO(41, 45, 67, 1),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          // Agregar un pequeño espacio vertical
          const SizedBox(
            height: 5,
          ),
          // Mostrar la información
          SelectableText(
            informacion,
            style: const TextStyle(
              color: Color.fromRGBO(58, 56, 56, 1),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // Método para generar la información del alumno
  Future<void> _generarInformacion() async {
    // Verificar si ya se está cargando la información
    if (cargando) return;

    // Actualizar el estado para indicar que se está cargando la información
    setState(() {
      vista = false;
      cargando = true;
      respuestaOk = false;
    });

    // Obtener la información mediante el proveedor de la aplicación
    dynamic response = await appProvider!.obtenerDatos();

    // Verificar el tipo de respuesta obtenida
    if (response is Response) {
      // Si la respuesta es del tipo Response, actualizar el estado con los datos obtenidos
      setState(() {
        datosFicha = DatosFicha.fromJson(response.data);
        cargando = false;
        respuestaOk = true;
      });
    }

    // Si la respuesta es del tipo RestError, manejar el error correspondiente
    if (response is RestError) {
      // Verificar si el tipo de error es cancelación
      if (response.type == DioErrorType.cancel) return;
      // Actualizar el estado con el mensaje de error
      setState(() {
        cargando = false;
        respuestaOk = false;
        mensaje = response.message;
      });
    }
  }
}
