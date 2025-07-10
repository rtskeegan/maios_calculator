import 'package:flutter/material.dart';
import 'package:maios_calculator/view/calculator_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CalculatorView());
  }
}
