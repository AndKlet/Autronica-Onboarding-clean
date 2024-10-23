import 'dart:convert';
import 'package:autron/src/view_models/software_model.dart';
import 'package:http/http.dart' as http;

/// A service class that handles software.
class SoftwareService {
  /// Gets a list of software.
  ///
  /// This method is a placeholder for a future API call.
  /// TODO: Implement software model
  /// TODO: Implement software API
  Future<List<Software>> getAllSoftwares() async {
    final response =
        await http.get(Uri.parse('http://164.92.218.9/software_list/'));
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

  Future<List<Software>> getSoftwareByDepartment(int departmentId) async {
    final response = await http.get(Uri.parse(
        'http://164.92.218.9/software_by_department/$departmentId/'));
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

  /// Gets software by status.

  /// Returns a list of software with the specified statuses by calling [getAllSoftware] and filtering the results.
  Future<List<Software>> getSoftwareByStatus(List<String> statuses) async {
    final allSoftware = await getAllSoftwares();
    return allSoftware
        .where((software) => statuses.contains(software.status))
        .toList();
  }

  /// Gets the count of accepted software.
  Future<int> getAcceptedSoftwareCount() async {
    final software = await getAllSoftwares();
    return software.where((s) => s.status == 'Accepted').length;
  }

  /// Gets the count of pending software.
  Future<int> getPendingSoftwareCount() async {
    final software = await getAllSoftwares();
    return software.where((s) => s.status == 'Pending').length;
  }

  /// Gets software by selected status.
  ///
  /// Returns a list of software filtered by the selected status.
  Future<List<Software>> getSoftwareBySelectedStatus(String status) async {
    final allSoftware = await getAllSoftwares();
    return allSoftware.where((software) => software.status == status).toList();
  }
}
