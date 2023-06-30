import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upla/ui/components/rounded_button.dart';
import 'package:upla/ui/pages/login/login_screen.dart';

import '../../../../constants.dart';
import '../../../../ui/pages/welcome/widget/background.dart';

class WelcomeDesktop extends StatelessWidget {
  const WelcomeDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.1,
          ),
          child: Row(
            children: [
              /**
               * 
               */
              Expanded(
                flex: 1,
                child: SvgPicture.asset(
                  "assets/icons/chat.svg",
                  height: size.height * 0.55,
                ),
              ),

              /**
              * 
              */
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                      textAlign: TextAlign.center,
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
                                left:
                                    BorderSide(color: kPrimaryColor, width: 5),
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
                    SizedBox(
                      height: size.height * 0.05,
                    ),

                    /**
                     * BUTTON PARA CAMBIAR DE PANTALL
                     */
                    RoundedButton(
                      text: "INICIAR",
                      press: () {
                        Navigator.pushReplacementNamed(
                          context,
                          LoginScreen.id,
                        );
                      },
                      height: size.height * 0.13,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
