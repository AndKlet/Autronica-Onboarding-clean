import 'package:flutter/material.dart';

class StatusAlert extends StatelessWidget {
  final String title;

  const StatusAlert({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 301,
      height: 91,
      child: Card(
        color: Colors.white,
        elevation: 6,
        shadowColor: Colors.black.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color.fromARGB(255, 229, 224, 224),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black, // Text color set to black
              fontSize: 22,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
