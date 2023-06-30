import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/pages/home/academico/acedemico_screen.dart';
import 'package:upla/ui/pages/home/perfil/centroayuda/centro_ayuda_lista_screen.dart';
import 'package:upla/ui/pages/home/financiero/financiero_screen.dart';
import 'package:upla/ui/pages/home/inicio/inicio_screen.dart';
import 'package:upla/ui/pages/home/perfil/perfil_Screen.dart';
import '../../../constants.dart';

class HomeScreen extends StatefulWidget {
  static String id = "home_page";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppProvider? appProvider;

  int index = 0;
  final PageController _pageController = PageController();

  List<Widget> myList = [
    const InicioScreen(),
    const FinancieroScreen(),
    const AcademicoScreen(),
    const PerfilScreen()
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(seconds: 3),
        () async {
          await appProvider?.notificationService.showLocalNotification(
            id: 0,
            title: "UPLA",
            body: "Bienvenidos, Universidad Peruana los Andes.",
            payload: "Acabas de iniciar sesión!",
          );
        },
      );
    });

    if (Platform.isAndroid) {
      FirebaseMessaging.onMessageOpenedApp.listen(
        (RemoteMessage message) {
          if (message.data["tipo"] != null) {
            if (message.data["tipo"] == "centroayuda") {
              Navigator.pushNamed(
                context,
                CentroAyudaListaScreen.id,
              );
            }
          }
        },
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 239, 239),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: index,
        onTap: (int i) {
          setState(() {
            index = i;
          });
          _pageController.jumpToPage(index);
        },
        backgroundColor: kPrimaryColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor:
            const Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        iconSize: 26.0,
        selectedFontSize: 11.0,
        unselectedFontSize: 11.0,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'INICIO'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance), label: 'FINANCIERO'),
          // BottomNavigationBarItem(icon: Icon(Icons.place), label: 'MARCAR'),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), label: 'CONSTANCIA'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'PERFIL'),
        ],
      ),
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return myList[index];
          },
        ),
      ),
    );
  }
}
