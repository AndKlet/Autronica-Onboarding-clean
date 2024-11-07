import 'package:autron/globals/theme/app_colors.dart';
import 'package:autron/src/app.dart';
import 'package:autron/src/screens/login_screen.dart';
import 'package:autron/src/services/software_service.dart';
import 'package:autron/src/services/request_service.dart';
import 'package:autron/src/services/user_service.dart';
import 'package:autron/src/services/home_service.dart';
import 'package:autron/src/view_models/user_model.dart';
import 'package:autron/src/widgets/announcement.dart';
import 'package:autron/src/widgets/statusAlert.dart';
import 'package:autron/src/widgets/app_bar.dart';
import 'package:flutter/material.dart';

/// The HomeScreen widget displays the home screen of the application.
///
/// The home screen displays the user's name and department, an announcement, and the number of accepted and pending software requests.
/// HomeScreen fetches user data from the [UserService], announcement data from the [HomeService], and software data from the [SoftwareService].
class HomeScreen extends StatelessWidget {
  final UserService _userService = UserService();
  final HomeService _homeService = HomeService();
  final RequestService _requestService = RequestService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _userService.getUserData(),
      builder: (context, snapshot) {
        // Check the connection state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading user data'));
        } else if (!snapshot.hasData) {
          // If no user data, navigate to LoginPage
          Future.microtask(() {
            (context as Element)
                .findAncestorStateOfType<MyAppState>()!
                .hideBottomNav(true);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          });
          return const SizedBox();
        } else {
          final user = snapshot.data!;
          return Scaffold(
            appBar: const CustomAppBar(title: 'Home'),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Display the user's name
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(top: 40, left: 16),
                      child: Text(
                        'Hi ${user.name}!',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 48,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  // Display the user's department
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Container(
                  //     margin: const EdgeInsets.only(top: 10, left: 16),
                  //     child: const Text(
                  //       'Engineering',
                  //       style: TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 20,
                  //         fontFamily: 'Inter',
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  FutureBuilder(
                    future: _homeService.getAnnouncement(),
                    builder: (context, announcementSnapshot) {
                      if (announcementSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (announcementSnapshot.hasError) {
                        return const Text('Error loading announcement');
                      } else {
                        final announcement =
                            announcementSnapshot.data as String;
                        return Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Announcement(
                            title: 'Announcement',
                            description: announcement,
                          ),
                        );
                      }
                    },
                  ),
                  // FutureBuilder(
                  //   future: _requestService.getAcceptedRequestCount(),
                  //   builder: (context, acceptedSnapshot) {
                  //     if (acceptedSnapshot.connectionState ==
                  //         ConnectionState.waiting) {
                  //       return const CircularProgressIndicator();
                  //     } else if (acceptedSnapshot.hasError) {
                  //       return const Text(
                  //           'Error loading accepted software count');
                  //     } else {
                  //       // If the snapshot has data, display the accepted software count
                  //       final acceptedCount = acceptedSnapshot.data as int;
                  //       return Container(
                  //         margin: const EdgeInsets.only(top: 30),
                  //         child: StatusAlert(
                  //             title: "Software granted"),
                  //       );
                  //     }
                  //   },
                  // ),
                  // FutureBuilder(
                  //   future: _requestService.getPendingRequestCount(),
                  //   builder: (context, pendingSnapshot) {
                  //     if (pendingSnapshot.connectionState ==
                  //         ConnectionState.waiting) {
                  //       return const CircularProgressIndicator();
                  //     } else if (pendingSnapshot.hasError) {
                  //       return const Text(
                  //           'Error loading pending software count');
                  //     } else {
                  //       // If the snapshot has data, display the pending software count
                  //       final pendingCount = pendingSnapshot.data as int;
                  //       return Container(
                  //         margin: const EdgeInsets.only(top: 20),
                  //         child: StatusAlert(
                  //             title: "Pending Requests",)
                  //       );
                  //     }
                  //   },
                  // ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
