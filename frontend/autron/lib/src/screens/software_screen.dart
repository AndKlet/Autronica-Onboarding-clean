import 'package:autron/src/view_models/department_model.dart';
import 'package:autron/src/view_models/software_model.dart';
import 'package:flutter/material.dart';
import 'package:autron/src/widgets/dropdown_searchbar.dart';
import 'package:autron/src/widgets/software_box.dart';
import 'package:autron/src/widgets/app_bar.dart';
import 'package:autron/src/screens/software_info_screen.dart';
import 'package:autron/src/services/software_service.dart';
import 'package:autron/src/services/department_service.dart';

/// The SoftwarePage widget displays the software screen of the application.
/// 
/// The software screen displays a dropdown search bar to select a department, and a list of software available for the selected department.
/// SoftwarePage fetches software data from the [SoftwareService] and department data from the [DepartmentService].
class SoftwarePage extends StatefulWidget {
  const SoftwarePage({super.key});

  @override
  State<SoftwarePage> createState() => _SoftwarePageState();
}

class _SoftwarePageState extends State<SoftwarePage> {
  final _softwareService = SoftwareService(); // Use SoftwareService
  final _departmentService = DepartmentService(); // Use DepartmentService
  List<Software> departmentSoftware = [];
  Department? selectedDepartment;

  // Method to fetch software for the selected department
  Future<void> _filterSoftwareByDepartment(int departmentId) async {
    try {
      final List<Software> softwares = await _softwareService
          .getSoftwareByDepartment(departmentId);
      setState(() {
        departmentSoftware = softwares;
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
    // FutureBuilder to fetch department data
    return FutureBuilder(
      future: _departmentService.getAllDepartments(),
      builder: (context, snapshot) {
        // Check the connection state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          // If the snapshot has data, display the software screen
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
                            name: software.name,
                            image: software.image,
                            onPressed: () {
                              if (selectedDepartment != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SoftwareInfoPage(
                                      id: software.id,
                                      name: software.name,
                                      image: software.image,
                                      department: selectedDepartment!,
                                    ),
                                  ),
                                );
                              }
                            });
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
