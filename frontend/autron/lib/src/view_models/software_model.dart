import 'package:autron/src/view_models/department_model.dart';

class Software {
  int id;
  String name;
  Department department;

  Software({required this.name, required this.department, required this.id});

  factory Software.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'department': Department department,
      } =>
        Software(
          id: id,
          name: name,
          department: department,
        ),
      _ => throw const FormatException('Failed to load software.'),
    };
  }
}
