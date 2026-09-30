import 'package:flutter/material.dart';

import 'screens/main_navigation.dart';

void main() {
  runApp(const CarrefourApp());
}

class CarrefourApp extends StatelessWidget {
  const CarrefourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carrefour Mauritius',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE30613),
          primary: const Color(0xFFE30613),
        ),
      ),
      home: const MainNavigation(),
    );
  }
}
