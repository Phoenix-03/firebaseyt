import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube/login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
        await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: "AIzaSyAyMitBa5a5qF9SSVLyeeu3aZUce_f_y3c", // paste your api key here
            appId: "1:702995124628:android:119b3a052e863e5f757f81", //paste your app id here
            messagingSenderId: "702995124628", //paste your messagingSenderId here
            projectId: "ytclone-87bbb", //paste your project id here
          ),
    );
    runApp(MyApp());
  } catch (e) {
    print('Error initializing Firebase: $e');
    // Handle the error gracefully, possibly show an error dialog or fallback screen
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Flutter YouTube UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(selectedItemColor: Colors.white),
      ),
      home: const GoogleSignInScreen(),
    );
  }
}