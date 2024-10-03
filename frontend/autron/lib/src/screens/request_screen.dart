import 'package:autron/globals/theme/app_colors.dart';
import 'package:autron/src/widgets/statusAlert.dart';
import 'package:autron/src/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class RequestScreen extends StatelessWidget {
  static const routeName = '/request-screen';

  const RequestScreen({super.key});
// Sample list of button titles

  static const List<Map<String, dynamic>> requests = [
    {
      'title': 'Adobe XD',
      'status': 'Accepted',
      'color': AppColors.autronAccepted,
      'count': 1
    },
    {
      'title': 'TensorFlow',
      'status': 'Pending',
      'color': AppColors.autronPending,
      'count': 2
    },
    {
      'title': 'PyTorch',
      'status': 'Declined',
      'color': AppColors.autronDeclined,
      'count': 0
    },
    {
      'title': 'Azure',
      'status': 'Accepted',
      'color': AppColors.autronAccepted,
      'count': 1
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Requests'),
      body: ListView.builder(
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final request = requests[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: StatusAlert(
                  title: request['title']!,
                  value: request['status']!,
                  count: request['count']!,
                  color: request['color']!),
            );
          }),
    );
  }
}
