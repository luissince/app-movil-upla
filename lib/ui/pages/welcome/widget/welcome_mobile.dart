import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:upla/ui/components/rounded_button.dart';
import 'package:upla/ui/pages/login/login_screen.dart';

import '../../../../constants.dart';
import '../../../../ui/pages/welcome/widget/background.dart';

class WelcomeMobile extends StatelessWidget {
  const WelcomeMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            /**
             * COMPONENTES PRINCIPALES
             */
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /**
                   * 
                   */
                  SvgPicture.asset(
                    "assets/icons/chat.svg",
                    height: size.height * 0.25,
                  ),
                  /**
                   * 
                   */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
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
                  const SizedBox(height: 20),
                  /**
                   * 
                   */
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(color: kPrimaryColor, width: 5),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Text(
                                    "NUEVOS",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "TIEMPOS",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Row(
                                children: const [
                                  Text(
                                    "NUEVOS",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "DESAFÍOS",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Row(
                                children: const [
                                  Text(
                                    "NUEVOS",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "COMPROMISOS",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /**
             * BUTTON PARA CAMBIAR DE PANTALL
             */
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: RoundedButton(
                text: "INICIAR",
                press: () async {
                  Navigator.pushReplacementNamed(
                    context,
                    LoginScreen.id,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
