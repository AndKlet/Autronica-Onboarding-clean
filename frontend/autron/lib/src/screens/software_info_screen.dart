import 'package:flutter/material.dart';
import 'package:autron/src/widgets/dropdown_searchbar.dart';
import 'package:autron/src/widgets/software_box.dart';
import 'package:autron/src/widgets/app_bar.dart';

class SoftwareInfoPage extends StatelessWidget {
  const SoftwareInfoPage({super.key});

//hardcoded page for the Okta software
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Okta Information'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Okta',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Okta is an identity and access management software used for securing digital environments. It provides single sign-on (SSO), multi-factor authentication (MFA), and lifecycle management for user identities.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            RichText(
              //RichText to make the status text is bold and the other not
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Status: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: 'Accepted',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const ElevatedButton(
              onPressed: null, // request button without a functionality atm
              child: Text('Request Access'),
            ),
          ],
        ),
      ),
    );
  }
}
