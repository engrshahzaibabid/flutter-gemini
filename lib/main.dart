import 'package:flutter/material.dart';
import 'package:flutter_gemini/src/features/chat/screens/chat_screen.dart';
import 'package:flutter_gemini/src/features/splash/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.lexendTextTheme(),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: GoogleFonts.lexend(
              fontWeight: FontWeight.w600,
              color: Colors.black, fontSize: 18
          ),
          centerTitle: true,
        )
      ),
      home: const SplashScreen(),
    );
  }
}

