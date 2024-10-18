import 'package:autron/src/view_models/department_model.dart';
import 'package:autron/src/view_models/software_model.dart';
import 'package:flutter/material.dart';
import 'package:autron/src/widgets/dropdown_searchbar.dart';
import 'package:autron/src/widgets/software_box.dart';
import 'package:autron/src/widgets/app_bar.dart';
import 'package:autron/src/screens/software_info_screen.dart';
import 'package:autron/src/services/software_service.dart';
import 'package:autron/src/services/department_service.dart';

class SoftwarePage extends StatefulWidget {
  const SoftwarePage({super.key});

  @override
  State<SoftwarePage> createState() => _SoftwarePageState();
}

class _SoftwarePageState extends State<SoftwarePage> {
  final _softwareService = SoftwareService(); // Use SoftwareService
  final _departmentService = DepartmentService(); // Assuming this still exists
  List<Software> departmentSoftware = [];
  Department? selectedDepartment;

  // Method to fetch software for the selected department
  Future<void> _filterSoftwareByDepartment(int departmentId) async {
    try {
      final List<Software> softwares = await _softwareService
          .getSoftwareByDepartment(departmentId); // Call from SoftwareService
      setState(() {
        departmentSoftware = softwares; // Update state with the software list
      });
    } catch (e) {
      setState(() {
        departmentSoftware = [];
      });
      print('Error fetching software: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _departmentService.getAllDepartments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          final departments = snapshot.data as List<Department>;

          return Scaffold(
            appBar: const CustomAppBar(title: 'Software'),
            body: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                DropdownSearchBar<Department>(
                  items: departments,
                  hintText: 'Select a Department',
                  onSelected: (Department department) {
                    setState(() {
                      selectedDepartment = department;
                    });
                    _filterSoftwareByDepartment(
                        department.id); // Filter software by department
                  },
                  getLabel: (Department department) => department.name,
                ),
                if (selectedDepartment != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Software available for: ${selectedDepartment!.name}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                if (departmentSoftware.isNotEmpty)
                  Center(
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: departmentSoftware.map((software) {
                        return SoftwareBox(
                          softwareName: software.name,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SoftwareInfoPage(
                                  softwareName: software.name,
                                  softwareStatus:
                                      software.status ?? 'Not Requested',
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          );
        }
      },
    );
  }
}
