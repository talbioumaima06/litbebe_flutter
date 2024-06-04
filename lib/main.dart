import 'package:litbebe/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:litbebe/pages/welcome/welcome.dart';
import '../pages/home/home.dart';
import '../pages/camera/camera.dart';
import '../pages/temperature/temperature.dart';
import '../pages/music/music.dart';
import '../pages/climatisation/climatisation.dart';
import '../pages/lumiere/lumiere.dart';
import '../pages/swing/swing.dart';
import '../pages/parametre/parametre.dart';
import '../api/firebase_api.dart';
import '../pages/webviewcontainer/WebViewContainer.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: const Welcome(),
      routes: {
        '/page1': (context) => const Home(),
        '/camera': (context) => const Camera(),
        Temperature.route: (context) => const Temperature(),
        '/music': (context) => const Music(),
        '/climatisation': (context) => const Climatisation(),
        '/lumiere': (context) =>const  Lumiere(),
        '/swing': (context) => const Swing(),
        '/parametre': (context) => const Parametre(),
        '/webviewtest': (context) => const WebViewContainer(),
        // Add more routes for each page
      },
    );
  }
}