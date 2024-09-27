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
            color: Colors.green[900],
            fontWeight: FontWeight.bold, // Set the AppBar title color to green
          ),
        ),
      ),
      body: ListView(
        children: requests.map((request) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity, // Makes the button full width
              height: 80, // Adjust the height of the button
              child: ElevatedButton(
                onPressed: () {
                  // Handle button press
                  print('${request['title']} pressed');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300], // Background color
                  foregroundColor: Colors.black, // Text color
                  padding:
                      EdgeInsets.symmetric(horizontal: 16), // Adjust padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the start
                  children: [
                    Text(
                      request['title']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold, // Make "Request X" bold
                      ),
                    ),
                    SizedBox(height: 4), // Space between the two texts
                    Text(
                      'Status: ${request['status']}',
                      style: TextStyle(
                        fontSize: 14, // Smaller font for status
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
