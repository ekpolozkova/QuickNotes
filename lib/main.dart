import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const QuickNotesApp());
}

class QuickNotesApp extends StatelessWidget {
  const QuickNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'QuickNotes',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}