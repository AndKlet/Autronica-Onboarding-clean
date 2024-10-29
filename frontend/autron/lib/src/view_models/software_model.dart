import 'package:autron/src/view_models/department_model.dart';
import 'package:autron/globals/urls.dart';

/// Software model
class Software {
  int id;
  String name;
  String? status; // Optional status
  Department department;
  String image;
  String description;
  String request_method;

  Software({
    required this.id,
    required this.name,
    this.status, // Optional status
    required this.department,
    required this.image,
    required this.description,
    required this.request_method
  });

  // Method to convert JSON to Software object
  factory Software.fromJson(Map<String, dynamic> json) {
    return Software(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json.containsKey('status') ? json['status'] as String? : null,
      department: Department.fromJson(json['department']),
      image: json['image'] != null && json['image'].startsWith('/')
        ? '${Urls.baseUrl}${json['image']}'
        : json['image'] ?? '',
      description: json['description'] as String,
      request_method: json['requestmethod'] as String,

    );
  }
}
