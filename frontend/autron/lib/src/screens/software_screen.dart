import 'package:flutter/material.dart';
import 'package:autron/src/widgets/dropdown_searchbar.dart';
import 'package:autron/src/widgets/software_box.dart';
import 'package:autron/src/widgets/app_bar.dart';
import 'package:autron/src/screens/software_info_screen.dart';

class SoftwarePage extends StatefulWidget {
  const SoftwarePage({super.key});

  @override
  State<SoftwarePage> createState() => _SoftwarePageState();
}

class _SoftwarePageState extends State<SoftwarePage> {
  final List<String> departments = [
    'Cyber Security',
    'Data Science',
    'Software Engineering',
    'UI/UX Design',
    'Cloud Computing',
    'Artificial Intelligence'
  ];

  final Map<String, List<String>> departmentSoftwares = {
    'Cyber Security': ['Okta', 'KnownBet64', 'miro', 'SLACK', 'git'],
    'Data Science': ['Jupyter', 'Pandas'],
    'Software Engineering': ['Git', 'Docker'],
    'UI/UX Design': ['Figma', 'Adobe XD'],
    'Cloud Computing': ['AWS', 'Azure'],
    'Artificial Intelligence': ['TensorFlow', 'PyTorch'],
  };

  String? selectedDepartment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Software'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            DropdownSearchBar<String>(
              // The dropdown menu
              items: departments,
              hintText: 'Select a Department',
              onSelected: (String department) {
                setState(() {
                  selectedDepartment = department;
                });
                print('Selected: $department');
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
            // Software boxes for the selected department
            if (selectedDepartment != null &&
                departmentSoftwares.containsKey(selectedDepartment))
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children:
                    departmentSoftwares[selectedDepartment]!.map((software) {
                  return SoftwareBox(
                    softwareName: software,
                    onPressed: () {
                      // Navigate to the SoftwareInfoPage when a software is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SoftwareInfoPage(),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
