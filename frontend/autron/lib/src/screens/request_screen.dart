import 'package:autron/globals/theme/app_colors.dart';
import 'package:autron/src/services/software_service.dart';
import 'package:autron/src/view_models/software_model.dart';
import 'package:autron/src/widgets/statusAlert.dart';
import 'package:autron/src/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class RequestScreen extends StatefulWidget {
  static const routeName = '/request-screen';

  const RequestScreen({super.key});

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final SoftwareService _softwareService = SoftwareService();

  // Initially set the selected status to 'Accepted'
  String selectedStatus = 'Accepted';

  // Function to change the selected status
  void _changeStatus(String newStatus) {
    setState(() {
      selectedStatus = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Requests'),
      body: Column(
        children: [
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _changeStatus('Accepted'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedStatus == 'Accepted'
                        ? AppColors.autronAccepted
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                  ),
                  child: const Text('Accepted'),
                ),
                ElevatedButton(
                  onPressed: () => _changeStatus('Pending'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedStatus == 'Pending'
                        ? AppColors.autronPending
                        : Colors.grey, // Change color if not selected
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                  ),
                  child: const Text(' Pending '),
                ),
                ElevatedButton(
                  onPressed: () => _changeStatus('Declined'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedStatus == 'Declined'
                        ? AppColors.autronDeclined
                        : Colors.grey, // Change color if not selected
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                  ),
                  child: const Text('Declined'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: FutureBuilder(
              future:
                  _softwareService.getSoftwareBySelectedStatus(selectedStatus),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text('Error loading software requests'));
                } else {
                  final List<Software> filteredRequests =
                      snapshot.data as List<Software>;

                  return ListView.builder(
                    itemCount: filteredRequests.length,
                    itemBuilder: (context, index) {
                      final request = filteredRequests[index];
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

                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: StatusAlert(
                          title: request.name,
                          value: request.status!,
                          count: statusCode,
                          color: statusColor,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
