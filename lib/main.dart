import 'package:flutter/material.dart';
import 'package:maadi_54_maps/screens/google_maps_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoogleMapsScreen(),
    );
  }
}
