// import 'package:example/example_horizontal/view/horizontal_example.dart';
import 'package:example/example_vertical/vertical_example.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VerticalExample(),
    );
  }
}
