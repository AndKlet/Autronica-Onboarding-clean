import 'package:flutter/material.dart';

class Announcement extends StatelessWidget {
  final String title;
  final String description;

  const Announcement({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 301,
        padding: const EdgeInsets.all(20),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF005E1D),
                  fontSize: 26,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              )
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                description,
                softWrap: true,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      );  }
}