import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        width: 160, // Width for box
        height: 120, // Height for box
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 5, // Blur radius
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              'assets/images/logo-placeholder.svg', // Path to logo
              width: 35, // Logo width
              height: 35, // Logo height
              fit: BoxFit.contain,
            ),
            Text(
              softwareName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
