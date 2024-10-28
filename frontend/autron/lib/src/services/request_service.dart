import 'dart:convert';
import 'package:autron/src/view_models/request_model.dart';
import 'package:http/http.dart' as http;

class RequestService {
  /// Gets a list of requests.
  Future<List<Request>> getAllRequests() async {
    final response =
        await http.get(Uri.parse('https://164.92.218.9/request_list/'));
    if (response.statusCode == 200) {
      // Split the response body into a list of maps department objects
      final List<Request> requests = (jsonDecode(response.body) as List)
          .map((request) => Request.fromJson(request))
          .toList();
      return requests;
    } else {
      throw Exception('Failed to load requests');
    }
  }

  /// Gets request by status.
  Future<List<Request>> getRequestByStatus(List<String> statuses) async {
    final allRequests = await getAllRequests();
    return allRequests
        .where((request) => statuses.contains(request.status))
        .toList();
  }

  /// Gets the count of accepted request.
  Future<int> getAcceptedRequestCount() async {
    final request = await getAllRequests();
    return request.where((s) => s.status == 'Accepted').length;
  }

  /// Gets the count of accepted request.
  Future<int> getPendingRequestCount() async {
    final request = await getAllRequests();
    return request.where((s) => s.status == 'Pending').length;
  }

  /// Returns a list of request filtered by the selected status.
  Future<List<Request>> getRequestBySelectedStatus(String status) async {
    final allRequest = await getAllRequests();
    return allRequest.where((request) => request.status == status).toList();
  }

  Future<void> requestSoftware(Request request) async {
    final response = await http.post(
      Uri.parse(
          'https://164.92.218.9/request_software/${request.software.id}/'),
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
