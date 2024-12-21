// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_car_service/pages/get_started.dart';
// import 'style/color.dart';
// import 'pages/settings.dart';
// import 'pages/login_page.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
  
//   if (kIsWeb) {
//     Firebase.initializeApp(
//         options: FirebaseOptions(
//             apiKey: "AIzaSyCrZz9Sk0RU650q2wtEzqZ4PBbE226zIco",
//             authDomain: "car-services-a23df.firebaseapp.com",
//             projectId: "car-services-a23df",
//             storageBucket: "car-services-a23df.firebasestorage.app",
//             messagingSenderId: "361541283071",
//             appId: "1:361541283071:web:f776782eed417390b470ca",
//             measurementId: "G-MPKLGHX6S9"));
//   } else {
//     await Firebase.initializeApp();
//   }

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: colorTheme,
//       ),
//       home: const GetStarted(),
//        routes: {
//     '/login': (context) => const LoginPage(),
//     '/settings': (context) => SettingsPage(email: ''), // Initially empty email
//   },
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_service/pages/get_started.dart';
import 'style/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCrZz9Sk0RU650q2wtEzqZ4PBbE226zIco",
        authDomain: "car-services-a23df.firebaseapp.com",
        projectId: "car-services-a23df",
        storageBucket: "car-services-a23df.firebasestorage.app",
        messagingSenderId: "361541283071",
        appId: "1:361541283071:web:f776782eed417390b470ca",
        measurementId: "G-MPKLGHX6S9",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: colorTheme,
        scaffoldBackgroundColor: bgColor, // Set the background color as needed
      ),
      home: const GetStarted(), // No need for onThemeChanged here
    );
  }
}
