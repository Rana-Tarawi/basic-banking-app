import 'package:basic_banking_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home Page",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            iconTheme: IconThemeData(color: Colors.black, size: 28)),
        iconTheme: const IconThemeData(color: Colors.white, size: 23),
        textTheme: Theme.of(context).textTheme.apply(
            displayColor: Colors.black,
            bodyColor: Colors.white,
            fontFamily: GoogleFonts.combo().fontFamily),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        )),
      ),
      home: const homeScreen(),
    );
  }
}
