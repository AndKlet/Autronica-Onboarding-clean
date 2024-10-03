import 'package:flutter/material.dart';
import 'package:autron/src/styles/styles.dart';

class SoftwareBox extends StatelessWidget {
  final String softwareName;
  final VoidCallback onPressed;

  const SoftwareBox({
    Key? key,
    required this.softwareName,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16.0),
        width: 160, // Fixed width for each box
        height: 120, // Fixed height for each box
        decoration: BoxDecoration(
          color: const Color.fromARGB(70, 22, 58, 167),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            softwareName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
