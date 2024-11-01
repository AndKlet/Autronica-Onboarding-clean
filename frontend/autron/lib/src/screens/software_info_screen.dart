import 'package:autron/src/services/request_service.dart';
import 'package:autron/src/view_models/department_model.dart';
import 'package:flutter/material.dart';
import 'package:autron/src/widgets/app_bar.dart';
import 'package:autron/src/widgets/request_access_form.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The SoftwareInfoPage widget displays the information of a software.
///
/// The software information page displays the software name and status, and allows the user to request access to the software.
class SoftwareInfoPage extends StatelessWidget {
  final int id;
  final String name;
  final Department department;
  final String? softwareInfo =
      'This is a placeholder for software information.';
  final String softwareDescription;
  final String? softwareImage;
  final String requestMethod;
  final RequestService _requestService = RequestService();

  SoftwareInfoPage({
    super.key,
    required this.name,
    required this.id,
    required this.department,
    required this.softwareDescription,
    this.softwareImage,
    required this.requestMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: '$name Information'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: softwareImage != null && softwareImage!.isNotEmpty
                    ? Image.network(
                        softwareImage!,
                        width: 200, // Set appropriate width
                        height: 200, // Set appropriate height
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return SvgPicture.asset(
                            'assets/images/logo-placeholder.svg',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : SvgPicture.asset(
                        'assets/images/logo-placeholder.svg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                softwareDescription, // Display the description here
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Request method: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: requestMethod,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              FutureBuilder(
                future: _requestService.getRequestBySoftwareId(id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return const Text('You have already requested access.');
                  } else {
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RequestAccessForm(
                              softwareName:
                                  name, // Pass software name to request form
                              softwareId: id,
                              imageURL: softwareImage,
                              department: department,
                            ),
                          ),
                        );
                      },
                      child: const Text('Request Access'),
                    );
                  }
                },
              )
            ],
          ),
        ));
  }
}
