import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:upla/network/rest/api_upla_edu_pe.dart';
import 'package:upla/network/rest/services_upla_edu_pe.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/routers/router.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'ui/pages/splash/splash_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // print("----------------------background------------------------------");
  // print(message.toString());
  // print("Handling a background message: ${message.messageId}");

  // NotificationService notificationService = NotificationService();
  // notificationService.initializePlatformNotifications();
  // await notificationService.showLocalNotification(
  //   id: 1,
  //   // title: message.data["title"],
  //   title: "tienes una notificación perros",
  //   // body: message.data["body"],
  //   body: "titititititiitititi",
  //   payload: "background",
  // );

  // AndroidNotification androidNotification = const AndroidNotification(
  //   priority: AndroidNotificationPriority.highPriority,
  //   channelId: 'channer_id',
  // );

  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //     alert: true, badge: true, sound: true);

  // await FlutterLocalNotificationsPlugin().show(
  //   0,
  //   "title",
  //   "body",
  //   const NotificationDetails(),
  // );

  // return Future<void>.value();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp();
  }

  ApiUplaEduPeDio.configureDio();
  ServicesUplaEduPeDio.configureDio();

  if (Platform.isAndroid) {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(
          create: (_) => AppProvider(),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UPLA',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor: Colors.black,
      ),
      routes: routers,
      initialRoute: SplashScreen.id,
    );
  }
}
