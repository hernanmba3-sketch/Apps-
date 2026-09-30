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
          seedColor: const Color.fromARGB(255, 12, 96, 130),
          primary: const Color.fromARGB(255, 12, 82, 179),
        ),
      ),
      home: const MainNavigation(),
    );
  }
}
