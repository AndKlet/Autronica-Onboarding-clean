import 'dart:convert';
import 'package:autron/src/view_models/department_model.dart';
import 'package:http/http.dart' as http;
import 'package:autron/globals/urls.dart';

/// A service that handles department data.
class DepartmentService {

  /// Fetches all departments from the server.
  ///
  /// Returns a list of [Department] objects.
  /// Throws an exception if the request fails.
  Future<List<Department>> getAllDepartments() async {
    final response =
        await http.get(Uri.parse('${Urls.baseUrl}/department_list/'));
    if (response.statusCode == 200) {
      // Split the response body into a list of maps department objects
      final List<Department> departments = (jsonDecode(response.body) as List)
          .map((department) => Department.fromJson(department))
          .toList();
      return departments;
    } else {
      throw Exception('Failed to load departments');
    }
  }
}
