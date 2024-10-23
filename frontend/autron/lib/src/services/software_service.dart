import 'dart:convert';
import 'package:autron/src/view_models/software_model.dart';
import 'package:http/http.dart' as http;

/// A service class that handles software.
class SoftwareService {
  /// Gets a list of software.
  ///
  /// Fetches software data from the server and returns a list of [Software] objects.
  /// Throws an exception if the request fails.
  Future<List<Software>> getAllSoftwares() async {
    final response =
        await http.get(Uri.parse('https://164.92.218.9/software_list/'));
    if (response.statusCode == 200) {
      // Split the response body into a list of maps department objects
      final List<Software> softwares = (jsonDecode(response.body) as List)
          .map((software) => Software.fromJson(software))
          .toList();
      return softwares;
    } else {
      throw Exception('Failed to load softwares');
    }
  }

  /// Gets software by department.
  ///
  /// Fetches software data from the server and returns a list of [Software] objects for the specified department.
  /// Throws an exception if the request fails.
  Future<List<Software>> getSoftwareByDepartment(int departmentId) async {
    final response = await http.get(Uri.parse(
        'https://164.92.218.9/software_by_department/$departmentId/'));
    if (response.statusCode == 200) {
      print(response.body);
      // Split the response body into a list of maps department objects
      final List<Software> softwares = (jsonDecode(response.body) as List)
          .map((software) => Software.fromJson(software))
          .toList();
      return softwares;
    } else {
      throw Exception('Failed to load softwares');
    }
  }
}
