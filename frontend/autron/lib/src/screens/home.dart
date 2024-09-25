import 'package:autron/src/widgets/announcement.dart';
import 'package:autron/src/widgets/statusAlert.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: const Stack(
        children: [
          Positioned(
            left: 30,
            top: 140,
            child: SizedBox(
              width: 200,
              height: 50,
              child: Text(
                'Hi JOHN',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 48,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0.02,
                  letterSpacing: -0.96,
                ),
              ),
            ),
          ),
          Positioned(
            left: 32,
            top: 190,
            child: SizedBox(
              width: 127,
              height: 20,
              child: Text(
                'Department',
                style: TextStyle(
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
            left: 46,
            top: 250,
            child: SizedBox(
              child: Announcement(
                title: 'Announcement',
                description:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod  tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim  veniam, quis nostrud exercitation ullamco.',
              ),
            ),
          ),
          
          
          Positioned(
            left: 46,
            top: 502,
            child: StatusAlert(title: "Software granted", value: "Currently", count: 17, color: Color(0xFF5AB443)),
          ),
          
          Positioned(
            left: 46,
            top: 621,
            child: StatusAlert(title: "Pending Requests", value: "Currently", count: 5, color: Color(0xFFE2CE4B)),
            ),
        ],
      ),
    );
  }
}