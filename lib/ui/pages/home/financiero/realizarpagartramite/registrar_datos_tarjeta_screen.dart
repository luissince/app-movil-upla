import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:upla/constants.dart';
import 'package:upla/ui/components/alert.dart';
import 'package:upla/ui/pages/home/financiero/realizarpagartramite/validar_tarjeta_screen.dart';

class RegistrarDatosTarjetaScreen extends StatefulWidget {
  static String id = "registrar_datos_tarjeta_page";

  const RegistrarDatosTarjetaScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RegistrarDatosTarjetaScreen> createState() =>
      _RegistrarDatosTarjetaScreenaState();
}

class _RegistrarDatosTarjetaScreenaState
    extends State<RegistrarDatosTarjetaScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Alert.confirm(
          context,
          "¿Está seguro de salir, los cambios se van perder?",
          aceptar: () {
            Navigator.pop(context);
          },
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(245, 248, 250, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          title: const Text(
            "Tarjetas",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Montserrat",
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          elevation: 0,
          leading: IconButton(
            onPressed: () async {
              Alert.confirm(
                context,
                "¿Está seguro de salir, los cambios se van perder?",
                aceptar: () {
                  Navigator.pop(context);
                },
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {},
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      /**
                       * 
                       */
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          children: const [
                            Text(
                              "Universidad Peruana Los Andes",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(41, 45, 67, 1),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "AGREGA SU TARJETA DE CRÉDITO O DÉBITO",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Color.fromRGBO(41, 45, 67, 1),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      /**
                       * 
                       */
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: 10,
                          right: 10,
                        ),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromRGBO(242, 222, 222, 1),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.warning,
                                  color: Color.fromRGBO(169, 68, 66, 1),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "ADVERTENCIA:",
                                  style: TextStyle(
                                    color: Color.fromRGBO(169, 68, 66, 1),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Se le va a cobrar un monto adicional por transacción de plataforma.",
                              style: TextStyle(
                                color: Color.fromRGBO(169, 68, 66, 1),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /**
                       * 
                       */
                      CreditCardWidget(
                        cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        cardHolderName: cardHolderName,
                        cvvCode: cvvCode,
                        showBackView: isCvvFocused,
                        obscureCardNumber: true,
                        obscureCardCvv: true,
                        labelCardHolder: "TARJETA",
                        cardBgColor: kPrimaryColor,
                        onCreditCardWidgetChange: (CreditCardBrand) {},
                      ),
                      CreditCardForm(
                        cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        cardHolderName: cardHolderName,
                        cvvCode: cvvCode,
                        onCreditCardModelChange: onCreditCardModelChange,
                        themeColor: Colors.blue,
                        formKey: formKey,
                        numberValidationMessage: "Ingrese el valor requerido",
                        dateValidationMessage: "Ingrese la fecha de expiración",
                        cvvValidationMessage: "Ingrese el cvv",
                        cardNumberDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Número de Tarjeta',
                          hintText: 'xxxx xxxx xxxx xxxx',
                        ),
                        expiryDateDecoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Fecha de Expiración',
                            hintText: 'xx/xx'),
                        cvvCodeDecoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'CVV',
                            hintText: 'xxx'),
                        cardHolderDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Titular de la Tarjeta',
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor:
                                const Color.fromRGBO(0, 124, 188, 1),
                            // primary: const Color.fromRGBO(0, 124, 188, 1),
                            elevation: 0,
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "CONTINUAR",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.pushReplacementNamed(
                                context,
                                ValidarTarjetaScreen.id,
                              );
                            } else {
                              Alert(context).showAlert(
                                  "Los datos ingresados en la tarjeta son incorrectas.");
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
