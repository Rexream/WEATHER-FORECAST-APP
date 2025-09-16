import 'package:flutter/material.dart';

import 'package:weather_app/pages/home_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1995E7),
        appBarTheme: AppBarTheme(backgroundColor: const Color(0xFF1995E7)),
      ),
      home: HomePage(),
    );
  }
}
