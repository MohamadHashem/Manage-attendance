import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mark_att/Screens/about.dart';
import 'package:mark_att/Screens/dates.dart';
import 'package:mark_att/Screens/login.dart';
import 'package:mark_att/Screens/mainpage.dart';
import 'package:mark_att/Screens/profile.dart';
import 'package:mark_att/Screens/registration.dart';
import 'package:mark_att/Screens/splash.dart';
import 'package:mark_att/Screens/students.dart';
import 'package:splashscreen/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'db2',
    options: Platform.isIOS || Platform.isMacOS
        ? FirebaseOptions(
      appId: '1:297855924061:ios:c6de2b69b03a5be8',
      apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
      projectId: 'flutter-firebase-plugins',
      messagingSenderId: '297855924061',
      databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
    )
        : FirebaseOptions(
      appId: '1:470858577855:android:1bd7260afd17150cd1530a',
      apiKey: 'AIzaSyA2lHZX0yKzlLF-4cBus4I3du1hJFUk6p8',
      messagingSenderId: '297855924061',
      projectId: 'attendance-senior',
      databaseURL: 'https://attendance-senior-default-rtdb.firebaseio.com',
    ),
  );
  // FirebaseUser currentFirebaseUser = await FirebaseAuth.instance.currentUser;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Brand-Regular',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id:(context)=>LoginPage(),
        MainPage.id:(context)=>MainPage(),
        RegistrationPage.id:(context)=>RegistrationPage(),
        // Splash.id:(context)=>Splash(),
        About.id:(context)=>About(),
        Profile.id:(context)=>Profile(),
        Dates.id:(context)=>Dates(),
        Students.id:(context)=>Students(),

      },
    );
  }
}

