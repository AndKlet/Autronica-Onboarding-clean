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
  final _softwareService = SoftwareService();
  final _departmentService = DepartmentService();
  final TextEditingController _softwareSearchController =
      TextEditingController();
  ValueNotifier<List<Software>> filteredDepartmentSoftware = ValueNotifier([]);
  List<Software> allDepartmentSoftware = [];
  Department? selectedDepartment;

  // Fetch software for the selected department
  Future<void> _filterSoftwareByDepartment(int departmentId) async {
    try {
      final List<Software> softwares =
          await _softwareService.getSoftwareByDepartment(departmentId);
      allDepartmentSoftware = softwares;
      filteredDepartmentSoftware.value = softwares;
    } catch (e) {
      allDepartmentSoftware = [];
      filteredDepartmentSoftware.value = [];
      print('Error fetching software: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Listen to software search changes and update the filtered software
    _softwareSearchController.addListener(() {
      final query = _softwareSearchController.text.toLowerCase();
      filteredDepartmentSoftware.value = allDepartmentSoftware
          .where((software) => software.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _softwareSearchController.dispose();
    filteredDepartmentSoftware.dispose();
    super.dispose();
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
                    _filterSoftwareByDepartment(department.id);
                  },
                  getLabel: (Department department) => department.name,
                ),
                if (selectedDepartment != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Software available for: ${selectedDepartment!.name}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _softwareSearchController,
                          decoration: const InputDecoration(
                            hintText: 'Search Software',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (selectedDepartment != null)
                  ValueListenableBuilder<List<Software>>(
                    valueListenable: filteredDepartmentSoftware,
                    builder: (context, softwareList, _) {
                      return Center(
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: softwareList.map((software) {
                            return SoftwareBox(
                              name: software.name,
                              imageURL: software.image,
                              onPressed: () {
                                if (selectedDepartment != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SoftwareInfoPage(
                                        id: software.id,
                                        name: software.name,
                                        softwareImage: software.image,
                                        department: selectedDepartment!,
                                        softwareDescription:
                                            software.description,
                                        requestMethod: software.request_method,
                                        servicenow_link: software.servicenow_link,
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        }
      },
    );
  }
}
