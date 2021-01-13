import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:car_license_exams/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '汽車駕照題庫',
        initialRoute: "/",
        routes: routes,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
                color: Color.fromRGBO(250, 251, 252, 1), elevation: 0),
            scaffoldBackgroundColor: Color.fromRGBO(250, 251, 252, 1),
            primaryColor: Color.fromRGBO(247, 249, 252, 1),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme:
                GoogleFonts.notoSansTextTheme(Theme.of(context).textTheme)),
        // darkTheme: ThemeData.dark(), // can custom color with primaryColor, visualDensity...
        debugShowCheckedModeBanner: false);
  }
}
