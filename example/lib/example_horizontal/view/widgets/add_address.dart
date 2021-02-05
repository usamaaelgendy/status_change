import 'package:flutter/material.dart';

class AddAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              "Add your Address",
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}
