import 'package:flutter/cupertino.dart';

class Summary extends StatelessWidget {
  const Summary({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Summary",
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
