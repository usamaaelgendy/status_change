import 'package:flutter/material.dart';

class AddAddress extends StatelessWidget {
  const AddAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Add your Address",
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
