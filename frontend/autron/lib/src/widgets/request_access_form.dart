import 'package:autron/globals/urls.dart';
import 'package:autron/src/services/request_service.dart';
import 'package:autron/src/view_models/department_model.dart';
import 'package:autron/src/view_models/request_model.dart';
import 'package:autron/src/view_models/software_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestAccessForm extends StatefulWidget {
  final String softwareName;
  final int softwareId;
  final String? imageURL;
  final Department department;

  const RequestAccessForm({
    super.key,
    required this.softwareName,
    required this.softwareId,
    this.imageURL,
    required this.department,
  });

  @override
  State<RequestAccessForm> createState() => _RequestAccessFormState();
}

class _RequestAccessFormState extends State<RequestAccessForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _receivingEmailController =
      TextEditingController(text: 'sigurdness.thorvaldsen@carrier.com');
  final TextEditingController _messageController = TextEditingController();
  final _storage = const FlutterSecureStorage();
  String _requestStatus = 'Not Requested';
  bool _isLoading = false;
  String? _errorMessage;
  final RequestService _requestService = RequestService();

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    // Load email from secure storage and set it in the email field
    final userEmail = await _storage.read(key: 'user_email');
    if (userEmail != null) {
      setState(() {
        _emailController.text = userEmail;
      });
    }
  }

  Future<void> _submitRequest() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text;
      final String receivingEmail = _receivingEmailController.text;
      final String message = _messageController.text;

      final url = Uri.parse('${Urls.baseUrl}/request_access/');

      final request = Request(
        id: 1,
        status: 'pending',
        software: Software(
          id: widget.softwareId,
          name: widget.softwareName,
          image: widget.imageURL,
          department: widget.department,
          description: 'This is a placeholder for software information.',
          request_method: 'email',
          servicenow_link:
              'This is a placeholder for the servicenow request ticket link.',
        ),
      );

      try {
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'email': email,
            'receiving_email': receivingEmail,
            'message': message,
            'software_name': widget.softwareName,
            'subject': 'Access Request for ${widget.softwareName}',
          }),
        );

        if (response.statusCode == 200) {
          try {
            await _requestService.requestSoftware(request);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to request software: $e')),
            );
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Request sent successfully')),
          );

          // Go back to the software screen
          Navigator.of(context).pop(true);
          Navigator.of(context).pop(true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to send request: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Access')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Your Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _receivingEmailController,
                decoration: const InputDecoration(
                  labelText: 'Receiving Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the receiving email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: 'Reasoning for request',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitRequest,
                child: const Text('Submit Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
