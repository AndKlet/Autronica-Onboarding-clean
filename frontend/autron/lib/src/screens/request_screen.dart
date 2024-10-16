import 'package:autron/globals/theme/app_colors.dart';
import 'package:autron/src/services/software_service.dart';
import 'package:autron/src/view_models/software_model.dart';
import 'package:autron/src/widgets/statusAlert.dart';
import 'package:autron/src/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class RequestScreen extends StatelessWidget {
  static const routeName = '/request-screen';
  final SoftwareService _softwareService = SoftwareService();

  RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Requests'),
      body: FutureBuilder(
        future: _softwareService
            .getSoftwareByStatus(['Accepted', 'Pending', 'Declined']),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading software requests'));
          } else {
            final List<Software> requests = snapshot.data as List<Software>;

            List<Map<String, dynamic>> mappedRequests = requests.map((request) {
              Color statusColor;
              int statusCode;

              switch (request.status) {
                case 'Accepted':
                  statusColor = AppColors.autronAccepted;
                  statusCode = 1;
                  break;
                case 'Pending':
                  statusColor = AppColors.autronPending;
                  statusCode = 2;
                  break;
                case 'Declined':
                  statusColor = AppColors.autronDeclined;
                  statusCode = 0;
                  break;
                default:
                  statusColor = Colors.grey;
                  statusCode = 0;
              }

              return {
                'title': request.name,
                'status': request.status,
                'color': statusColor,
                'count': statusCode,
              };
            }).toList();

            return ListView.builder(
              itemCount: mappedRequests.length,
              itemBuilder: (context, index) {
                final request = mappedRequests[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StatusAlert(
                    title: request['title']!,
                    value: request['status']!,
                    count: request['count']!,
                    color: request['color']!,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
