import 'package:autron/src/view_models/department_model.dart';
import 'package:autron/src/view_models/software_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestAccessForm extends StatefulWidget {
  final String softwareName;
  final int softwareId;
  final String imageURL;
  final Department department;

  const RequestAccessForm({
    super.key,
    required this.softwareName,
    required this.softwareId,
    required this.imageURL,
    required this.department,
  });

  @override
  State<RequestAccessForm> createState() => _RequestAccessFormState();
}

class _RequestAccessFormState extends State<RequestAccessForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _receivingEmailController =
      TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  Future<void> _submitRequest() async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text;
      final String receivingEmail = _receivingEmailController.text;
      final String message = _messageController.text;

      final url = Uri.parse('https://164.92.218.9/request_access/');

      final software = Software(
          id: widget.softwareId,
          name: widget.softwareName,
          image: widget.imageURL,
          department: widget.department);

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
            'software_name':
                widget.softwareName, // Pass the software name to the backend
            'subject': 'Access Request for ${widget.softwareName}',
            'software': software.toJson(),
          }),
        );

        if (response.statusCode == 200) {
          // Handle success
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Request sent successfully')),
          );
        } else {
          // Handle error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to send request: ${response.body}')),
          );
        }
      } catch (e) {
        // Handle any error that occurs during the request
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
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
                  labelText: 'Message',
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
