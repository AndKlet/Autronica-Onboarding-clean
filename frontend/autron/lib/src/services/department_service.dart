import 'dart:convert';
import 'package:autron/src/view_models/department_model.dart';
import 'package:http/http.dart' as http;

class DepartmentService {
  Future<List<Department>> getAllDepartments() async {
    final response =
        await http.get(Uri.parse('http://164.92.218.9:8000/department_list/'));
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
