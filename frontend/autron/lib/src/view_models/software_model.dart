import 'package:autron/src/view_models/department_model.dart';

class Software {
  int id;
  String name;
  String? status; // Optional status
  Department department;

  Software({
    required this.id,
    required this.name,
    this.status, // Optional status
    required this.department,
  });

  factory Software.fromJson(Map<String, dynamic> json) {
    return Software(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json.containsKey('status') ? json['status'] as String? : null,
      department: Department.fromJson(json['department']),
    );
  }
}
