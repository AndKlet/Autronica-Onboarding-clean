/// Department model
class Department {
  int id;
  String name;

  Department({required this.name, required this.id});

  // Method to convert JSON to Department object
  factory Department.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
      } =>
        Department(
          id: id,
          name: name,
        ),
      _ => throw const FormatException('Failed to load department.'),
    };
  }
}
