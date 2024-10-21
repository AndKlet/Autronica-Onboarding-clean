import 'dart:convert';
import 'package:autron/src/view_models/request_model.dart';
import 'package:http/http.dart' as http;

class RequestService {
  Future<void> requestSoftware(Request request) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/request_software/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to request software');
    }
  }
}
