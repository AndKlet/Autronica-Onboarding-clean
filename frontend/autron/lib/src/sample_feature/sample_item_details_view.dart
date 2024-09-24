import 'package:flutter/material.dart';
import '../screens/RequestScreen.dart';

/// Displays detailed information about a SampleItem.
class SampleItemDetailsView extends StatelessWidget {
  const SampleItemDetailsView({super.key});

  static const routeName = '/sample_item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('More Information Here'),
            const SizedBox(height: 20), // Adds some spacing
            ElevatedButton(
              onPressed: () {
                // Navigate to the RequestScreen when the button is pressed
                Navigator.pushNamed(context, RequestScreen.routeName);
              },
              child: const Text('Go to Request Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
