import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class Announcement extends StatelessWidget {
  final String title;
  final String description;

  const Announcement({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(6),
      color: Colors.black,
      strokeWidth: 2,
      dashPattern: const [10, 10],
      child: Container(
        width: 301,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF005E1D),
                fontSize: 26,
                fontStyle: FontStyle.italic,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
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
      ),
    );
  }
}
