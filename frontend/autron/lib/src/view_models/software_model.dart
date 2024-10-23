import 'package:autron/src/view_models/department_model.dart';

class Software {
  int id;
  String name;
  Department department;

  Software({
    required this.id,
    required this.name,
    required this.department,
  });

  factory Software.fromJson(Map<String, dynamic> json) {
    return Software(
      id: json['id'] as int,
      name: json['name'] as String,
      department: Department.fromJson(json['department']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'department': department.toJson(),
    };
  }
}
