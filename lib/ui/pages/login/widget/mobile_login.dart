import 'package:dio/dio.dart';

import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upla/network/exception/rest_error.dart';
import 'package:upla/ui/pages/home/home_screen.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/components/activity_indicator.dart';
import 'package:upla/ui/components/alert.dart';
import 'package:upla/ui/components/rounded_button.dart';
import 'package:upla/ui/components/rounded_input_field.dart';
import 'package:upla/ui/components/rounded_password_field.dart';

import '../../../../constants.dart';
import '../../../../model/session.dart';
import 'background_login.dart';

class MobileLogin extends StatefulWidget {
  const MobileLogin({Key? key}) : super(key: key);

  @override
  State<MobileLogin> createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  AppProvider? appProvider;

  TextEditingController codigoController = TextEditingController();
  FocusNode codigoFocus = FocusNode();

  TextEditingController claveController = TextEditingController();
  FocusNode claveFocus = FocusNode();

  CancelToken cancelToken = CancelToken();
  bool loading = false;
  bool viewPassword = true;

  @override
  void initState() {
    super.initState();
    codigoFocus.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    codigoFocus.dispose();
    claveFocus.dispose();
    cancelToken.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    appProvider = Provider.of<AppProvider>(context);

    return BackgroundLogin(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /**
                      * 
                      */
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "U",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 34),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  Text(
                    "P",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 34),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  Text(
                    "L",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 34),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  Text(
                    "A",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 34),
                  ),
                ],
              ),

              /**
                      * 
                      */
              const Text(
                "UNIVERSIDAD PERUANA LOS ANDES",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 7,
                ),
              ),
              const SizedBox(height: 10),
              /** 
               * 
               */
              const Text(
                "INICIAR SESIÓN",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              /**
               * 
               */
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.30,
              ),
              const SizedBox(height: 10),
              /**
               * 
               */
              loading
                  ? const ActivityIndicator(
                      color: kPrimaryColor,
                    )
                  : const SizedBox(height: 0),
              const SizedBox(height: 10),

              /**
               * 
               */
              RoundedInputField(
                  text: codigoController,
                  hintText: "Tú código",
                  onSubmitted: (value) {
                    if (value != "" && claveController.text == "") {
                      claveFocus.requestFocus();
                      return;
                    }

                    if (codigoController.text != "" &&
                        claveController.text != "") {
                      _onEventLogin(appProvider!);
                    }
                  },
                  myFocusNode: codigoFocus),
              /**
               * 
               */
              RoundedPasswordField(
                text: claveController,
                obscureText: viewPassword,
                onSubmitted: (value) {
                  if (codigoController.text == "") {
                    codigoFocus.requestFocus();
                    return;
                  }

                  if (codigoController.text != "" && claveController.text != "") {
                    _onEventLogin(appProvider!);
                  }
                },
                myFocusNode: claveFocus,
                press: () {
                  setState(() {
                    viewPassword = !viewPassword;
                  });
                },
              ),
              /**
               * 
               */
              RoundedButton(
                text: "INICIAR SESIÓN",
                press: () => _onEventLogin(appProvider!),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onEventLogin(AppProvider appProvider) async {
    if (loading) {
      return;
    }

    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if (codigoController.text.isEmpty) {
      Alert.show(context, "Ingrese su código.", callback: () {
        codigoFocus.requestFocus();
      });

      return;
    }

    if (claveController.text.isEmpty) {
      Alert.show(context, "Ingrese su contraseña.", callback: () {
        claveFocus.requestFocus();
      });
      return;
    }

    setState(() {
      loading = true;
    });
   
    Map<String, dynamic> payload = {
      "codigo": codigoController.text,
      "contraseña": claveController.text,
      "token": appProvider.token,
    };

    dynamic response =
        await appProvider.login(payload, cancelToken: cancelToken);

    if (response is Response) {
      var user = response.data;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", user["token"]);
      prefs.setString("docNumId", user["docNumId"]);
      prefs.setString("persPaterno", user["persPaterno"]);
      prefs.setString("persMaterno", user["persMaterno"]);
      prefs.setString("persNombre", user["persNombre"]);
      prefs.setString("usuario", codigoController.text);
      prefs.setString("clave", claveController.text);

      appProvider.isLoading = true;
      appProvider.isSignout = false;

      Session session =  Session();
      session.token = prefs.getString("token")!;
      session.docNumId = prefs.getString("docNumId")!;
      session.persPaterno = prefs.getString("persPaterno")!;
      session.persMaterno = prefs.getString("persMaterno")!;
      session.persNombre = prefs.getString("persNombre")!;
      session.usuario = codigoController.text;
      session.clave = claveController.text;
      appProvider.session = session;

      _navigateHome();
      return;
    }

    if (response is RestError) {
      if (response.type == DioErrorType.cancel) return;

      setState(() {
        loading = false;
      });

      Alert(context).showAlert(response.message);
    }
  }

  void _navigateHome() {
    Navigator.pushReplacementNamed(
      context,
      HomeScreen.id,
    );
  }
}
