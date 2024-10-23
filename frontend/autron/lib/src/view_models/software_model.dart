import 'package:autron/src/view_models/department_model.dart';

/// Software model
class Software {
  int id;
  String name;
  Department department;
  String image;

  Software({
    required this.id,
    required this.name,
    required this.department,
    required this.image,
  });

  // Method to convert JSON to Software object
  factory Software.fromJson(Map<String, dynamic> json) {
    return Software(
      id: json['id'] as int,
      name: json['name'] as String,
      department: Department.fromJson(json['department']),
      image: json['image'] != null && json['image'].startsWith('/')
        ? 'https://164.92.218.9${json['image']}'
        : json['image'] ?? '',

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
