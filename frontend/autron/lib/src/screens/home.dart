import 'package:autron/src/widgets/announcement.dart';
import 'package:autron/src/widgets/statusAlert.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: Text(
                'Hi JOHN',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 48,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                'Department',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Announcement(
                title: 'Announcement',
                description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod  tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim  veniam, quis nostrud exercitation ullamco.',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: const StatusAlert(
                title: "Software granted", 
                value: "Currently", 
                count: 17, 
                color: Color(0xFF5AB443)
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const StatusAlert(
                title: "Pending Requests", 
                value: "Currently", 
                count: 5, 
                color: Color(0xFFE2CE4B)
              ),
            ),
          ],
        ),
      )
    );
  }
}

