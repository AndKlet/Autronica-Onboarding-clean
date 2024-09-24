import 'package:flutter/material.dart';

class StatusAlert extends StatelessWidget {
  final String title;
  final String value;
  final int count;
  final Color color;

  const StatusAlert({super.key, required this.title, required this.value, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 301,
          height: 91,
          child: Container(
            width: 301,
            height: 91,
            decoration: ShapeDecoration(
              color: Color(0xFFF8F8F8),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: color,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 30,
                  top: 70,
                  child: SizedBox(
                    width: 100,
                    height: 24,
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0.06,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 132,
                  top: 70,
                  child: Text(
                    count.toString(),
                    style: TextStyle(
                      color: color,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0.06,
                      letterSpacing: -0.40,
                    ),
                  ),
                ),
                Positioned(
                  left: 265,
                  top: 56,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: ShapeDecoration(
                      color: color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 27,
                  top: 38,
                  child: SizedBox(
                    width: 210,
                    height: 28,
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0.05,
                        letterSpacing: -0.48,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}