// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/auth/auth.dart';
import 'package:shop_app/firebase_options.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    /*FirebaseOptions(
            apiKey: "AIzaSyCAuh3krO-JOtpcXeFQoJ7EUIUWIuczQFs",
            appId: "1:333430240330:web:9a6eea3b61e8952f19a2b3",
            messagingSenderId: "333430240330",
            projectId: "shop-flutter-a5266"));*/
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'shop app',
      debugShowCheckedModeBanner: false,
      //themeMode: ThemeMode.system,
      // make the theme as  mentioned
      // themeMode:ThemeMode.dark,
      // themeMode:ThemeMode.light,
      // theme:TAppTheme.lightTheme,
      //  darkTheme: TAppTheme.darkTheme,
      home: AuthPage(),
    );
  }
}
