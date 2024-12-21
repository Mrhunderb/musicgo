import 'package:flutter/material.dart';
import 'package:musicgo/pages/home.dart';
import 'package:musicgo/themes/light.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MusicGo',
      theme: lightTheme,
      home: const HomePage(),
    );
  }
}
