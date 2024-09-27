import 'package:autron/src/widgets/statusAlert.dart';
import 'package:flutter/material.dart';

class RequestScreen extends StatelessWidget {
  static const routeName = '/request-screen';

  const RequestScreen({super.key});
// Sample list of button titles


  static const List<Map<String, String>> requests = [
    {'title': 'Request 1', 'status': 'Accepted'},
    {'title': 'Request 2', 'status': 'Pending'},
    {'title': 'Request 3', 'status': 'Rejected'},
    {'title': 'Request 4', 'status': 'Accepted'},
    {'title': 'Request 5', 'status': 'Pending'},
    {'title': 'Request 6', 'status': 'Pending'},
    {'title': 'Request 7', 'status': 'Pending'},
    {'title': 'Request 8', 'status': 'Pending'},
    {'title': 'Request 9', 'status': 'Pending'},
    {'title': 'Request 10', 'status': 'Pending'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Requests',
          style: TextStyle(
        title: Text(
          'Requests',
          style: TextStyle(
            color: Colors.green[900],
            fontWeight: FontWeight.bold, // Set the AppBar title color to green
          ),
        ),
        ),
      ),
      body: ListView(
        children: requests.map((request) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
           // ignore: prefer_const_constructors
           child: StatusAlert(title: "Request", value: "Status", count: 10, color:  Color(0xFF5AB443)),
          );
        }).toList(),
      ),
    );
  }
}

}
