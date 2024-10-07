import 'package:autron/globals/theme/app_colors.dart';
import 'package:autron/src/services/software_service.dart';
import 'package:autron/src/services/user_service.dart';
import 'package:autron/src/services/home_service.dart';
import 'package:autron/src/widgets/announcement.dart';
import 'package:autron/src/widgets/statusAlert.dart';
import 'package:autron/src/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final UserService _userService = UserService();
  final HomeService _homeService = HomeService();
  final SoftwareService _softwareService = SoftwareService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userService.getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading user data'));
        } else {
          final user = snapshot.data as Map<String, dynamic>;
          return Scaffold(
            appBar: const CustomAppBar(title: 'Home'),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: Text(
                      'Hi ${user['name']}!',
                      style: const TextStyle(
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
                      user['department'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  
                  FutureBuilder(
                    future: _homeService.getAnnouncement(),
                    builder: (context, announcementSnapshot) {
                      if (announcementSnapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (announcementSnapshot.hasError) {
                        return const Text('Error loading announcement');
                      } else {
                        final announcement = announcementSnapshot.data as String;
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
                  
                  FutureBuilder(
                    future: _softwareService.getAcceptedSoftwareCount(),
                    builder: (context, acceptedSnapshot) {
                      if (acceptedSnapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (acceptedSnapshot.hasError) {
                        return const Text('Error loading accepted software count');
                      } else {
                        final acceptedCount = acceptedSnapshot.data as int;
                        return Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: StatusAlert(
                              title: "Software granted",
                              value: "Currently",
                              count: acceptedCount,
                              color: AppColors.autronAccepted),
                        );
                      }
                    },
                  ),
                  
                  FutureBuilder(
                    future: _softwareService.getPendingSoftwareCount(),
                    builder: (context, pendingSnapshot) {
                      if (pendingSnapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (pendingSnapshot.hasError) {
                        return const Text('Error loading pending software count');
                      } else {
                        final pendingCount = pendingSnapshot.data as int;
                        return Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: StatusAlert(
                              title: "Pending Requests",
                              value: "Currently",
                              count: pendingCount,
                              color: AppColors.autronPending),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}