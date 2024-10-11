class Department {
  int id;
  String name;

  Department({required this.name, required this.id});

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
