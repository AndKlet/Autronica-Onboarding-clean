import 'dart:convert';
import 'package:autron/src/view_models/software_model.dart';
import 'package:http/http.dart' as http;
import 'package:autron/globals/urls.dart';

/// A service class that handles software.
class SoftwareService {

  /// Gets a list of software.
  ///
  /// Fetches software data from the server and returns a list of [Software] objects.
  /// Throws an exception if the request fails.
  Future<List<Software>> getAllSoftwares() async {
    final response =
        await http.get(Uri.parse('${Urls.baseUrl}/software_list/'));
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
        '${Urls.baseUrl}/software_by_department/$departmentId/'));
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
  ///
  /// Fetches software data from the server and returns a list of [Software] objects for the specified status.
  Future<List<Software>> getSoftwareByStatus(List<String> statuses) async {
    final allSoftware = await getAllSoftwares();
    return allSoftware
        .where((software) => statuses.contains(software.status))
        .toList();
  }

  /// Gets the count of accepted software.
  ///
  /// Returns the count of software with the status 'Accepted'.
  Future<int> getAcceptedSoftwareCount() async {
    final software = await getAllSoftwares();
    return software.where((s) => s.status == 'Accepted').length;
  }

  /// Gets the count of pending software.
  ///
  /// Returns the count of software with the status 'Pending'.
  Future<int> getPendingSoftwareCount() async {
    final software = await getAllSoftwares();
    return software.where((s) => s.status == 'Pending').length;
  }

  /// Gets software by selected status.
  ///
  /// Returns a list of software filtered by the selected status.
  ///
  Future<List<Software>> getSoftwareBySelectedStatus(String status) async {
    final allSoftware = await getAllSoftwares();
    return allSoftware.where((software) => software.status == status).toList();
  }
}
