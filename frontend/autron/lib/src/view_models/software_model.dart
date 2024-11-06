import 'package:autron/src/view_models/department_model.dart';
import 'package:autron/globals/urls.dart';

/// Software model
class Software {
  int id;
  String name;
  Department department;
  String? image;
  String description;
  String request_method;
  String servicenow_link;

  Software(
      {required this.id,
      required this.name,
      required this.department,
      this.image,
      required this.description,
      required this.request_method,
      required this.servicenow_link});

  // Method to convert JSON to Software object
  factory Software.fromJson(Map<String, dynamic> json) {
    return Software(
      id: json['id'] as int,
      name: json['name'] as String,
      department: Department.fromJson(json['department']),
      image: json['image'] != null && json['image'].startsWith('/')
          ? '${Urls.baseUrl}${json['image']}'
          : json['image'] ?? '',
      description: json['description'] as String,
      request_method: json['requestmethod'] as String,
      servicenow_link: json['servicenow_link'] as String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'department': department.toJson(),
      'image': image!.startsWith(Urls.baseUrl)
          ? image!.replaceFirst(Urls.baseUrl, '')
          : image,
    };
  }
}
