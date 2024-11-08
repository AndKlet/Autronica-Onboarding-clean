import 'dart:convert';
import 'package:autron/globals/urls.dart';
import 'package:autron/src/services/user_service.dart';
import 'package:autron/src/view_models/request_model.dart';
import 'package:autron/src/view_models/user_model.dart';
import 'package:http/http.dart' as http;

class RequestService {
  final UserService _userService = UserService();
  
  /// Gets a list of requests.
  Future<List<Request>> getAllRequests() async {
    // Fetch user data from secure storage
    final User? user = await _userService.getUserData();

    if (user == null) {
      throw Exception('User data not found');
    }

   final response = await http.get(
      Uri.parse('${Urls.baseUrl}/request_list/'),
      headers: {
        'uid': user.id,
      },
    );
    if (response.statusCode == 200) {
      // Split the response body into a list of maps department objects
      print('Requests loaded');
      final List<Request> requests = (jsonDecode(response.body) as List)
          .map((request) => Request.fromJson(request))
          .toList();
      return requests;
    } else {
      throw Exception('Failed to load requests with status ${response.statusCode}');
    }
  }

  /// Gets request by software id.
  Future<Request?> getRequestBySoftwareId(int softwareId) async {
    final allRequests = await getAllRequests();
    try {
      return allRequests.firstWhere(
        (request) => request.software.id == softwareId,
      );
    } catch (e) {
      return null;
    }
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
    final User? user = await _userService.getUserData();
    if (user == null) {
      throw Exception('User data not found');
    }
    final response = await http.post(
      Uri.parse('${Urls.baseUrl}/request_software/${request.software.id}/${user.id}/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );
    if (response.statusCode == 200) {
      print('Software requested');
      return;
    } else {
      throw Exception('Failed to request software');
    }
  }
}
