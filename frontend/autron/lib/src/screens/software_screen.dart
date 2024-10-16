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
  final SoftwareService _softwareService = SoftwareService();
  final DepartmentService _departmentService = DepartmentService();

  String? selectedDepartment;
  List<Map<String, dynamic>> departmentSoftware = [];

  void _filterSoftwareByDepartment(String department) async {
    final allSoftware = await _softwareService.getAllSoftware();
    setState(() {
      departmentSoftware = allSoftware
          .where((software) => software['departments'].contains(department))
          .toList();
    });
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
          final departments = (snapshot.data as List)
              .map((department) => department.name as String)
              .toList();

          return Scaffold(
            appBar: const CustomAppBar(title: 'Software'),
            body: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                DropdownSearchBar<String>(
                  items: departments,
                  hintText: 'Select a Department',
                  onSelected: (String department) {
                    setState(() {
                      selectedDepartment = department;
                    });
                    _filterSoftwareByDepartment(department);
                  },
                  getLabel: (String department) => department,
                ),
                if (selectedDepartment != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Software available for: $selectedDepartment',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                if (departmentSoftware.isNotEmpty)
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: departmentSoftware.map((software) {
                      return SoftwareBox(
                        softwareName: software['name'],
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SoftwareInfoPage(
                                softwareName: software['name'],
                                softwareInfo: software['info'],
                                softwareStatus: software['status'],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
              ],
            ),
          );
        }
      },
    );
  }
}
