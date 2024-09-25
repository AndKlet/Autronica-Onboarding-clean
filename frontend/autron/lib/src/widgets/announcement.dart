import 'package:flutter/material.dart';

class Announcement extends StatelessWidget {
  final String title;
  final String description;

  const Announcement({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310,
      height: 242,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 310,
              height: 242,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Positioned(
            left: 60,
            top: 10,
            child: SizedBox(
              width: 187,
              height: 53,
                child: Text(
                  title,
                  softWrap: true,
                  style: const TextStyle(
                    color: Color(0xFF005E1D),
                    fontSize: 26,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                )
              ),
            ),
          Positioned(
            left: 33,
            top: 50,
            child: SizedBox(
              width: 245,
              height: 163,
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
          ),
        ],
      ),
    );
  }
}