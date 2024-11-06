import 'package:autron/globals/theme/app_colors.dart';
import 'package:autron/src/services/request_service.dart';
import 'package:autron/src/view_models/request_model.dart';
import 'package:autron/src/widgets/statusAlert.dart';
import 'package:autron/src/widgets/app_bar.dart';
import 'package:flutter/material.dart';

/// The RequestScreen widget displays the software requests screen of the application.
///
/// The software requests screen displays the software requests with the status 'Accepted', 'Pending', or 'Declined'.
/// RequestScreen fetches software data from the [SoftwareService].
class RequestScreen extends StatefulWidget {
  static const routeName = '/request-screen';

  const RequestScreen({super.key});

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final RequestService _requestService = RequestService();

  // Initially set the selected status to 'Accepted'
  String selectedStatus = 'Pending';

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
                  // Change the status to 'Pending' when the button is pressed
                  onPressed: () => _changeStatus('Pending'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedStatus == 'Pending'
                        ? const Color.fromARGB(255, 151, 155, 156)
                        : const Color.fromARGB(255, 205, 203, 203), // Change color if not selected
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                  ),
                  child: const Text(' Sent '),
                ),
                ElevatedButton(
                  // Change the status to 'Accepted' when the button is pressed
                  onPressed: () => _changeStatus('Accepted'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedStatus == 'Accepted'
                        ? AppColors.autronAccepted
                        : const Color.fromARGB(255, 205, 203, 203),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                  ),
                  child: const Text('Accepted'),
                ),

                ElevatedButton(
                  // Change the status to 'Declined' when the button is pressed
                  onPressed: () => _changeStatus('Declined'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedStatus == 'Declined'
                        ? AppColors.autronDeclined
                        : const Color.fromARGB(255, 205, 203, 203), // Change color if not selected
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
            // FutureBuilder to fetch software requests
            child: FutureBuilder(
              future:
                  _requestService.getRequestBySelectedStatus(selectedStatus),
              builder: (context, snapshot) {
                // Check the connection state
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text('Error loading software requests'));
                } else {
                  final List<Request> filteredRequests =
                      snapshot.data as List<Request>;

                  return ListView.builder(
  itemCount: filteredRequests.length,
  itemBuilder: (context, index) {
    final request = filteredRequests[index];
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: StatusAlert(
        title: request.software.name,
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
