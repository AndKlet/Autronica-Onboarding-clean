import 'package:autron/src/view_models/software_model.dart';

class Request {
  int id;
  String status;
  Software software;

  Request({
    required this.id,
    required this.status,
    required this.software,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'] as int,
      status: json['status'] as String,
      software: Software.fromJson(json['software']),
    );
  }

  // Serialize Request object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'software': software.toJson(),
    };
  }
}
