import 'package:flutter/material.dart';

import 'example_vertical/vertical_example.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VerticalExample(),
    );
  }
}
