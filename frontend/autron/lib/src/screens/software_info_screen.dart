import 'package:autron/src/services/request_service.dart';
import 'package:autron/src/view_models/department_model.dart';
import 'package:autron/src/view_models/request_model.dart';
import 'package:autron/src/view_models/software_model.dart';
import 'package:flutter/material.dart';
import 'package:autron/src/widgets/app_bar.dart';
import 'package:autron/src/widgets/request_access_form.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The SoftwareInfoPage widget displays the information of a software.
///
/// The software information page displays the software name and status, and allows the user to request access to the software.
class SoftwareInfoPage extends StatefulWidget {
  final int softwareId;
  final String softwareName;
  final String? softwareStatus;
  final String? softwareInfo =
      'This is a placeholder for software information.';
  final String softwareDescription;
  final String? softwareImage;
  final String requestMethod;

  const SoftwareInfoPage({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.department,
  });

  @override
  _SoftwareInfoPageState createState() => _SoftwareInfoPageState();
}

class _SoftwareInfoPageState extends State<SoftwareInfoPage> {
  bool _isLoading = false;
  String? _errorMessage;
  String _requestStatus = 'Not Requested';

  Future<void> _requestSoftwareAccess() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: '$softwareName Information'),
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
                softwareName,
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
                      text: 'Status: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: softwareStatus,
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
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RequestAccessForm(
                        softwareName:
                            softwareName, // Pass the software name to the request form
                      ),
                    ),
                  );
                },
                child: const Text('Request Access'),
              )
            ],
          ),
        ));
  }
}
