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

  // Serialize Request object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'software':
          software.toJson(), // Assuming `toJson` is defined in Software model
    };
  }
}
