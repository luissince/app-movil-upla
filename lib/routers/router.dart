import 'package:flutter/material.dart';
import 'package:upla/ui/pages/conection/connection_screen.dart';
import 'package:upla/ui/pages/home/academico/encuesta/encuesta_procesando_screen.dart';
import 'package:upla/ui/pages/home/academico/encuesta/encuesta_respuesta_screen.dart';
import 'package:upla/ui/pages/home/perfil/centroayuda/centro_ayuda_detalle_screen.dart';
import 'package:upla/ui/pages/home/perfil/centroayuda/centro_ayuda_frecuente_screen.dart';
import 'package:upla/ui/pages/home/perfil/centroayuda/centro_ayuda_lista_screen.dart';
import 'package:upla/ui/pages/home/perfil/centroayuda/centro_ayuda_screen.dart';
import 'package:upla/ui/pages/home/perfil/centroayuda/centro_ayuda_crear_screen.dart';
import 'package:upla/ui/pages/home/perfil/centroayuda/centro_ayuda_procesando_screen.dart';
import 'package:upla/ui/pages/home/perfil/centroayuda/centro_ayuda_respuesta_screen.dart';
import 'package:upla/ui/pages/home/academico/constanciamatricula/constancia_matricula_screen.dart';
import 'package:upla/ui/pages/home/academico/encuesta/encuenta_crear_screen.dart';
import 'package:upla/ui/pages/home/academico/encuesta/encuenta_screen.dart';
import 'package:upla/ui/pages/home/academico/mallacurricular/malla_curricular_screen.dart';
import 'package:upla/ui/pages/home/academico/progresocurricular/progreso_curricular_screen.dart';
import 'package:upla/ui/pages/home/academico/registrarmatricula/registrar_matricula_screen.dart';
import 'package:upla/ui/pages/home/academico/visualizarnota/visualizar_nota_screen.dart';
import 'package:upla/ui/pages/home/financiero/estadocuenta/estado_deuda_screen.dart';
import 'package:upla/ui/pages/home/financiero/pagorealizados/pagos_realizados_screen.dart';
import 'package:upla/ui/pages/home/financiero/realizarpagartramite/procesando_pago_tramite_screen.dart';
import 'package:upla/ui/pages/home/financiero/realizarpagartramite/realizar_pago_tramite_screen.dart';
import 'package:upla/ui/pages/home/financiero/realizarpagartramite/registrar_datos_tarjeta_screen.dart';
import 'package:upla/ui/pages/home/financiero/realizarpagartramite/respuesta_pago_tramite_screen.dart';
import 'package:upla/ui/pages/home/financiero/realizarpagartramite/validar_tarjeta_screen.dart';
import 'package:upla/ui/pages/home/home_screen.dart';
import 'package:upla/ui/pages/home/perfil/datospersonales/datos_personales_screen.dart';
import 'package:upla/ui/pages/home/perfil/documentos/documentos_screen.dart';
import 'package:upla/ui/pages/home/perfil/generarqr/generar_qr_screen.dart';
import 'package:upla/ui/pages/home/perfil/seguridad/seguridad_screen.dart';
import 'package:upla/ui/pages/home/perfil/zonawifi/zona_wifi_screen.dart';
import 'package:upla/ui/pages/login/login_screen.dart';
import 'package:upla/ui/pages/splash/splash_screen.dart';
import 'package:upla/ui/pages/version/version_screen.dart';
import 'package:upla/ui/pages/welcome/welcome_screen.dart';

Map<String, WidgetBuilder> routers = <String, WidgetBuilder>{
  SplashScreen.id: (context) => const SplashScreen(),
  WelcomeScreen.id: (context) => const WelcomeScreen(),
  VersionScreen.id: (context) => const VersionScreen(),
  ConnectionScreen.id: (context) => const ConnectionScreen(),
  LoginScreen.id: (context) => const LoginScreen(),
  HomeScreen.id: (context) => const HomeScreen(),
  CentroAyudaScreen.id: (context) => const CentroAyudaScreen(),
  CentroAyudaCrearScreen.id: (context) => const CentroAyudaCrearScreen(),
  EstadoDeudaScreen.id: (context) => const EstadoDeudaScreen(),
  PagosRealizadosScreen.id: (context) => const PagosRealizadosScreen(),
  RealizarPagoTramiteScreen.id: (context) => const RealizarPagoTramiteScreen(),
  RegistrarDatosTarjetaScreen.id: (context) =>
      const RegistrarDatosTarjetaScreen(),
  ValidarTarjetaScreen.id: (context) => const ValidarTarjetaScreen(),
  ProcesandoPagoTramiteScreen.id: (context) =>
      const ProcesandoPagoTramiteScreen(),
  RespuestaPagoTramiteScreen.id: (context) =>
      const RespuestaPagoTramiteScreen(),
  ConstanciaMatriculaScreen.id: (context) => const ConstanciaMatriculaScreen(),
  VisualizarNotaScreen.id: (context) => const VisualizarNotaScreen(),
  MallaCurricularScreen.id: (context) => const MallaCurricularScreen(),
  ProgresoCurrillarScreen.id: (context) => const ProgresoCurrillarScreen(),
  EncuetaScreen.id: (context) => const EncuetaScreen(),
  EncuestaCrearScreen.id: (context) => const EncuestaCrearScreen(),
  RegistrarMatriculaScreen.id: (context) => RegistrarMatriculaScreen(),
  CentroAyudaProcesandoScreen.id: (context) =>
      const CentroAyudaProcesandoScreen(),
  CentroAyudaRespuestaScreen.id: (context) =>
      const CentroAyudaRespuestaScreen(),
  CentroAyudaDetalleScreen.id: (context) => const CentroAyudaDetalleScreen(),
  CentroAyudaListaScreen.id: (context) => const CentroAyudaListaScreen(),
  CentroAyudaFrecuenteScreen.id: (context) =>
      const CentroAyudaFrecuenteScreen(),
  EncuestaProcesandoScreen.id: (context) => const EncuestaProcesandoScreen(),
  EncuestaRespuestaScreen.id: (context) => const EncuestaRespuestaScreen(),
  DatosPersonalesScreen.id: (context) => const DatosPersonalesScreen(),
  SeguridadScreen.id: (context) => const SeguridadScreen(),
  DocumentosScreen.id: (context) => const DocumentosScreen(),
  ZonaWifiScreen.id: (context) => const ZonaWifiScreen(),
  GenerarQrScreen.id: (context) => const GenerarQrScreen(),
};
